#!/usr/sbin/dtrace -s

#pragma D option quiet

inline int TOP_FILES = 10;

dtrace:::BEGIN
{
        printf("Tracing... Hit Ctrl-C to end.\n");
}

smb:::op-Read-start, smb:::op-ReadX-start,
smb:::op-Write-start, smb:::op-WriteX-start
{
        /* currently the done event fires in the same thread as start */
        self->start = timestamp;
}

smb:::op-Read-done, smb:::op-ReadX-done   { this->dir = "read"; }
smb:::op-Write-done, smb:::op-WriteX-done { this->dir = "write"; }

smb:::op-Read-done, smb:::op-ReadX-done,
smb:::op-Write-done, smb:::op-WriteX-done
/self->start/
{
        this->elapsed = timestamp - self->start;
        @rw[this->dir] = quantize(this->elapsed / 1000);
        @host[args[0]->ci_remote] = sum(this->elapsed);
        @file[args[1]->soi_curpath] = sum(this->elapsed);
        self->start = 0;
}

dtrace:::END
{
        printf("CIFS read/write distributions (us):\n");
        printa(@rw);

        printf("\nCIFS read/write by host (total us):\n");
        normalize(@host, 1000);
        printa(@host);

        printf("\nCIFS read/write top%d files (total us):\n", TOP_FILES);
        normalize(@file, 1000);
        trunc(@file, TOP_FILES);
        printa(@file);
}
