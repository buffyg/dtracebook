#!/usr/sbin/dtrace -Zs

#pragma D option quiet
#pragma D option switchrate=10hz

dtrace:::BEGIN
{
        printf("%-12s%6s%6s%-12.12s%-12s%-4s%s\n", "TIME(ms)", "UID",
            "PID", "PROCESS", "CALL", "KB", "PATH");
}

/* see uts/common/fs/ufs/ufs_vnops.c */

fbt::ufs_read:entry, fbt::ufs_write:entry
{
        self->path = args[0]->v_path;
        self->kb = args[1]->uio_resid / 1024;
}

fbt::ufs_open:entry
{
        self->path = (*(struct vnode **)arg0)->v_path;
        self->kb = 0;
}

fbt::ufs_close:entry, fbt::ufs_ioctl:entry, fbt::ufs_getattr:entry,
fbt::ufs_readdir:entry
{
        self->path = args[0]->v_path;
        self->kb = 0;
}

fbt::ufs_read:entry, fbt::ufs_write:entry, fbt::ufs_open:entry,
fbt::ufs_close:entry, fbt::ufs_ioctl:entry, fbt::ufs_getattr:entry,
fbt::ufs_readdir:entry
{
        printf("%-12d%6d%6d%-12.12s%-12s%-4d%s\n", timestamp / 1000000,
            uid, pid, execname, probefunc, self->kb,
        self->path!= NULL? stringof(self->path): "<null>");
        self->path = 0; self->kb = 0;
}
