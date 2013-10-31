#!/usr/sbin/dtrace -Zs

#pragma D option quiet
#pragma D option switchrate=10

self int depth;

dtrace:::BEGIN
{
        printf("%s%6s/%-4s%10s %16s:%-4s%-8s --%s\n", "C", "PID", "TID",
            "DELTA(us)", "FILE", "LINE", "TYPE", "FUNC");
}

php*:::function-entry,
php*:::function-return
/self->last == 0/
{
        self->last = timestamp;
}

php*:::function-entry
/arg0/
{
        this->delta = (timestamp - self->last) / 1000;
        printf("%d%6d/%-4d%10d %16s:%-4d%-8s%*s->%s\n", cpu, pid, tid,
            this->delta, basename(copyinstr(arg1)), arg2, "func",
            self->depth * 2, "", copyinstr(arg0));
        self->depth++;
        self->last = timestamp;
}

php*:::function-return
/arg0/
{
        this->delta = (timestamp - self->last) / 1000;
        self->depth -= self->depth > 0? 1: 0;
        printf("%d%6d/%-4d%10d %16s:%-4d%-8s%*s<-%s\n", cpu, pid, tid,
            this->delta, basename(copyinstr(arg1)), arg2, "func",
        self->depth * 2, "", copyinstr(arg0));
        self->last = timestamp;
}
