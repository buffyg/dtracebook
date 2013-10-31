#!/usr/sbin/dtrace -Zs

#pragma D option quiet

dtrace:::BEGIN
{
        printf("Tracing... Hit Ctrl-C to end.\n");
}

python*:::function-entry
{
        self->depth++;
        self->exclude[self->depth] = 0;
        self->function[self->depth] = timestamp;
}

python*:::function-return
/self->function[self->depth]/
{
        this->elapsed_incl = timestamp - self->function[self->depth];
        this->elapsed_excl = this->elapsed_incl - self->exclude[self->depth];
        self->function[self->depth] = 0;
        self->exclude[self->depth] = 0;
        this->file = basename(copyinstr(arg0));
        this->name = copyinstr(arg1);

        @num[this->file, "func", this->name] = count();
        @num["-", "total", "-"] = count();
        @types_incl[this->file, "func", this->name] = sum(this->elapsed_incl);
        @types_excl[this->file, "func", this->name] = sum(this->elapsed_excl);
        @types_excl["-", "total", "-"] = sum(this->elapsed_excl);

        self->depth--;
        self->exclude[self->depth] += this->elapsed_incl;
}

dtrace:::END
{
        printf("\nCount,\n");
        printf("  %-20s%-10s%-32s%8s\n", "FILE", "TYPE", "NAME", "COUNT");
        printa("  %-20s%-10s%-32s%@8d\n", @num);

        normalize(@types_excl, 1000);
        printf("\nExclusive function elapsed times (us),\n");
        printf("  %-20s%-10s%-32s%8s\n", "FILE", "TYPE", "NAME", "TOTAL");
        printa("  %-20s%-10s%-32s%@8d\n", @types_excl);

        normalize(@types_incl, 1000);
        printf("\nInclusive function elapsed times (us),\n");
        printf("  %-20s%-10s%-32s%8s\n", "FILE", "TYPE", "NAME", "TOTAL");
        printa("  %-20s%-10s%-32s%@8d\n", @types_incl);
}
