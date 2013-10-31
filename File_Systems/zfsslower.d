#!/usr/sbin/dtrace -s

#pragma D option quiet
#pragma D option defaultargs
#pragma D option switchrate=10hz

dtrace:::BEGIN
{
        printf("%-20s%-16s%1s%4s%6s%s\n", "TIME", "PROCESS",
            "D", "KB", "ms", "FILE");
        min_ns = $1 * 1000000;
}

/* see uts/common/fs/zfs/zfs_vnops.c */

fbt::zfs_read:entry,
fbt::zfs_write:entry
{
        self->path = args[0]->v_path;
        self->kb = args[1]->uio_resid / 1024;
        self->start = timestamp;
}

fbt::zfs_read:return,
fbt::zfs_write:return
/self->start && (timestamp - self->start) >= min_ns/
{
        this->iotime = (timestamp - self->start) / 1000000;
        this->dir = probefunc == "zfs_read"? "R": "W";
        printf("%-20Y%-16s%1s%4d%6d%s\n", walltimestamp,
            execname, this->dir, self->kb, this->iotime,
            self->path!= NULL? stringof(self->path): "<null>");
}

fbt::zfs_read:return,
fbt::zfs_write:return
{
        self->path = 0; self->kb = 0; self->start = 0;
}
