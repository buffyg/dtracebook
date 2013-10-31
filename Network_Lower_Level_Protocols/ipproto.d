#!/usr/sbin/dtrace -s

#pragma D option quiet

dtrace:::BEGIN
{
        printf("Tracing... Hit Ctrl-C to end.\n");
}

ip:::send,
ip:::receive
{
        this->protostr = args[2]->ip_ver == 4?
            args[4]->ipv4_protostr: args[5]->ipv6_nextstr;
        @num[args[2]->ip_saddr, args[2]->ip_daddr, this->protostr] = count();
}

dtrace:::END
{
        printf("  %-28s%-28s%6s%8s\n", "SADDR", "DADDR", "PROTO", "COUNT");
        printa("  %-28s%-28s%6s%@8d\n", @num);
}
