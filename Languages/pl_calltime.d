#!/usr/sbin/dtrace -Zs

#pragma D option quiet

dtrace:::BEGIN
{
        printf("Tracing... Hit Ctrl-C to end.\n");
}

perl*:::sub-entry
{
        self->depth++;
        self->exclude[self->depth] = 0;
        self->sub[self->depth] = timestamp;
}

perl*:::sub-return
/self->sub[self->depth]/
{
        this->elapsed_incl = timestamp - self->sub[self->depth];
        this->elapsed_excl = this->elapsed_incl - self->exclude[self->depth];
        self->sub[self->depth] = 0;
        self->exclude[self->depth] = 0;
        this->file = basename(copyinstr(arg1));
        this->name = copyinstr(arg0);

        @num[this->file, "sub", this->name] = count();
        @num["-", "total", "-"] = count();
        @types_incl[this->file, "sub", this->name] = sum(this->elapsed_incl);
        @types_excl[this->file, "sub", this->name] = sum(this->elapsed_excl);
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
        printf("\nExclusive subroutine elapsed times (us),\n");
        printf("  %-20s%-10s%-32s%8s\n", "FILE", "TYPE", "NAME", "TOTAL");
        printa("  %-20s%-10s%-32s%@8d\n", @types_excl);

        normalize(@types_incl, 1000);
        printf("\nInclusive subroutine elapsed times (us),\n");
        printf("  %-20s%-10s%-32s%8s\n", "FILE", "TYPE", "NAME", "TOTAL");
        printa("  %-20s%-10s%-32s%@8d\n", @types_incl);
}
