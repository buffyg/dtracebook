#!/usr/sbin/dtrace -s

#pragma D option quiet
#pragma D option switchrate=10hz

dtrace:::BEGIN
{
        printf("%-20s%-12s%-12s%-12s%-12s\n", "TIME", "STATE", "REASON",
            "ACTION", "EXPLANATION");
}

fbt::fctl_pkt_error:entry
{
        self->state = args[1];
        self->reason = args[2];
        self->action = args[3];
        self->expln = args[4];
}

fbt::fctl_pkt_error:entry
/self->state/
{
        printf("%-20Y%-12s%-12s%-12s%-12s\n", walltimestamp,
            stringof(*self->state), stringof(*self->reason),
            stringof(*self->action), stringof(*self->expln));

        self->state = 0; self->reason = 0; self->action = 0; self->expln = 0;
}
