#!/usr/sbin/dtrace -s

#pragma D option quiet
#pragma D option defaultargs
#pragma D option switchrate=10hz

dtrace:::BEGIN
{
        printf("%-12s%6s%6s%-12.12s%-12s%-4s%s\n", "TIME(ms)", "UID",
            "PID", "PROCESS", "CALL", "KB", "PATH");
}

/* see sys/bsd/sys/vnode_if.h */

fbt::VNOP_READ:entry, fbt::VNOP_WRITE:entry
{
        self->path = ((struct vnode *)arg0)->v_name;
        self->kb = ((struct uio *)arg1)->uio_resid_64 / 1024;
}

fbt::VNOP_OPEN:entry
{
        self->path = ((struct vnode *)arg0)->v_name;
        self->kb = 0;
}

fbt::VNOP_CLOSE:entry, fbt::VNOP_IOCTL:entry, fbt::VNOP_GETATTR:entry,
fbt::VNOP_READDIR:entry
{
        self->path = ((struct vnode *)arg0)->v_name;
        self->kb = 0;
}

fbt::VNOP_READ:entry, fbt::VNOP_WRITE:entry, fbt::VNOP_OPEN:entry,
fbt::VNOP_CLOSE:entry, fbt::VNOP_IOCTL:entry, fbt::VNOP_GETATTR:entry,
fbt::VNOP_READDIR:entry
/execname!= "dtrace" && ($$1 == NULL || $$1 == execname)/
{
        printf("%-12d%6d%6d%-12.12s%-12s%-4d%s\n", timestamp / 1000000,
        uid, pid, execname, probefunc, self->kb,
        self->path!= NULL? stringof(self->path): "<null>");
}

fbt::VNOP_READ:entry, fbt::VNOP_WRITE:entry, fbt::VNOP_OPEN:entry,
fbt::VNOP_CLOSE:entry, fbt::VNOP_IOCTL:entry, fbt::VNOP_GETATTR:entry,
fbt::VNOP_READDIR:entry
{
        self->path = 0; self->kb = 0;
}
