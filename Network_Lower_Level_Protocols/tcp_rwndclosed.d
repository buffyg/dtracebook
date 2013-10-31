#!/usr/sbin/dtrace -s

#pragma D option quiet

tcp:::send
/ args[4]->tcp_window == 0 && (args[4]->tcp_flags & TH_RST) == 0 /
{
        rwndclosed[args[1]->cs_cid] = timestamp;
        rwndrnxt[args[1]->cs_cid] = args[3]->tcps_rnxt;
        @numrwndclosed[args[2]->ip_daddr, args[4]->tcp_dport] = count();
}

tcp:::receive
/ rwndclosed[args[1]->cs_cid] && args[4]->tcp_seq >= rwndrnxt[args[1]->cs_cid] /
{
        @meantimeclosed[args[2]->ip_saddr, args[4]->tcp_sport] =
            avg(timestamp - rwndclosed[args[1]->cs_cid]);
        @stddevtimeclosed[args[2]->ip_saddr, args[4]->tcp_sport] =
            stddev(timestamp - rwndclosed[args[1]->cs_cid]);
        rwndclosed[args[1]->cs_cid] = 0;
        rwndrnxt[args[1]->cs_cid] = 0;
}

END
{
        printf("%-20s%-8s%-25s%-8s%-8s\n",
            "Remote host", "Port", "TCP Avg RwndClosed(ns)", "StdDev",
            "Num");
        printa("%-20s%-8d%@-25d%@-8d%@-8d\n", @meantimeclosed,
        @stddevtimeclosed, @numrwndclosed);
}
