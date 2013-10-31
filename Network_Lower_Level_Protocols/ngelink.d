#!/usr/sbin/dtrace -s

#pragma D option quiet
#pragma D option switchrate

int seen[nge_t *];
int up[nge_t *];
int speed[nge_t *];
int duplex[nge_t *];
int last[nge_t *];

dtrace:::BEGIN
{
        printf("%-20s %-10s%6s%8s%8s  %s\n", "TIME", "INT", "UP",
            "SPEED", "DUPLEX", "DELTA(ms)");
}

fbt::nge_check_copper:entry
{
        self->ngep = args[0];
}

fbt::nge_check_copper:return
/self->ngep && (!seen[self->ngep] ||
        (up[self->ngep]!= self->ngep->param_link_up ||
        speed[self->ngep]!= self->ngep->param_link_speed ||
        duplex[self->ngep]!= self->ngep->param_link_duplex))/
{
        this->delta = last[self->ngep]? timestamp - last[self->ngep]: 0;
        this->name = stringof(self->ngep->ifname);
        printf("%-20Y %-10s%6d%8d%8d  %d\n", walltimestamp, this->name,
            self->ngep->param_link_up, self->ngep->param_link_speed,
        self->ngep->param_link_duplex, this->delta / 1000000);
        seen[self->ngep] = 1;
        last[self->ngep] = timestamp;
}

fbt::nge_check_copper:return
/self->ngep/
{
        up[self->ngep] = self->ngep->param_link_up;
        speed[self->ngep] = self->ngep->param_link_speed;
        duplex[self->ngep] = self->ngep->param_link_duplex;
        self->ngep = 0;
}
