#!/usr/sbin/dtrace -s

#pragma D option quiet
#pragma D option switchrate=10hz

dtrace:::BEGIN
{
        printf("%6s%6s%15s:%-5s     %15s:%-5s%6s%s\n",
            "TIME", "PID", "LADDR", "PORT", "RADDR", "PORT", "BYTES", "FLAGS");
}

tcp:::send
{
        this->length = args[2]->ip_plength - args[4]->tcp_offset;
        printf("%6d%6d%15s:%-5d  -> %15s:%-5d%6d (",
            timestamp/1000, args[1]->cs_pid, args[2]->ip_saddr,
            args[4]->tcp_sport, args[2]->ip_daddr, args[4]->tcp_dport,
            this->length);
}

tcp:::receive
{
        this->length = args[2]->ip_plength - args[4]->tcp_offset;
        printf("%6d%6d%15s:%-5d  <- %15s:%-5d%6d (",
            timestamp/1000, args[1]->cs_pid, args[2]->ip_daddr,
            args[4]->tcp_dport, args[2]->ip_saddr, args[4]->tcp_sport,
            this->length);
}

tcp:::send,
tcp:::receive
{
        printf("%s", args[4]->tcp_flags & TH_FIN? "FIN|": "");
        printf("%s", args[4]->tcp_flags & TH_SYN? "SYN|": "");
        printf("%s", args[4]->tcp_flags & TH_RST? "RST|": "");
        printf("%s", args[4]->tcp_flags & TH_PUSH? "PUSH|": "");
        printf("%s", args[4]->tcp_flags & TH_ACK? "ACK|": "");
        printf("%s", args[4]->tcp_flags & TH_URG? "URG|": "");
        printf("%s", args[4]->tcp_flags & TH_ECE? "ECE|": "");
        printf("%s", args[4]->tcp_flags & TH_CWR? "CWR|": "");
        printf("%s", args[4]->tcp_flags == 0? "null ": "");
        printf("\b)\n");
}
