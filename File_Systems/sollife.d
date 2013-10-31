#!/usr/sbin/dtrace -s

#pragma D option quiet
#pragma D option switchrate=10hz

dtrace:::BEGIN
{
        printf("%-12s%6s%6s%-12.12s%-12s%s\n", "TIME(ms)", "UID",
            "PID", "PROCESS", "CALL", "PATH");
}

/* see /usr/include/sys/vnode.h */

fbt::fop_create:entry,
fbt::fop_remove:entry
{
        printf("%-12d%6d%6d%-12.12s%-12s%s/%s\n",
            timestamp / 1000000, uid, pid, execname, probefunc,
            args[0]->v_path!= NULL? stringof(args[0]->v_path): "<null>",
            stringof(arg1));
}
