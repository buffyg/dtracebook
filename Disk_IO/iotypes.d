#!/usr/sbin/dtrace -s

#pragma D option quiet

dtrace:::BEGIN
{
        printf("Tracing... Hit Ctrl-C to end.\n");
}

io:::start
{
        start_time[arg0] = timestamp;
}

io:::done
/this->start = start_time[arg0]/
{
        this->delta = (timestamp - this->start) / 1000;
        this->type = args[0]->b_flags & B_READ? "read": "write";
        this->type = args[0]->b_flags & B_PHYS?
            strjoin("phys-", this->type): this->type;
        this->type = args[0]->b_flags & B_ASYNC?
            strjoin("async-", this->type): this->type;
        this->pageio = args[0]->b_flags & B_PAGEIO? "yes": "no";
        this->error = args[0]->b_error!= 0?
            strjoin("Error:", lltostr(args[0]->b_error)): "Success";

        @num[this->type, this->pageio, this->error] = count();
        @average[this->type, this->pageio, this->error] = avg(this->delta);
        @total[this->type, this->pageio, this->error] = sum(this->delta);

        start_time[arg0] = 0;
}

dtrace:::END
{
        normalize(@total, 1000);
        printf("\n %-18s%6s%10s%11s%11s%12s\n", "TYPE", "PAGEIO",
            "RESULT", "COUNT", "AVG(us)", "TOTAL(ms)");
        printa(" %-18s%6s%10s%@11d%@11d%@12d\n", @num, @average, @total);
}
