#!/usr/sbin/dtrace -s

#pragma D option quiet
#pragma D option switchrate=10hz

dtrace:::BEGIN
{
        deleg[0] = "none";
        deleg[1] = "read";
        deleg[2] = "write";
        deleg[-1] = "any";

        printf("Tracing NFSv4 delegation events...\n");
        printf("%-21s%-20s%s\n", "TIME", "EVENT", "DETAILS");
}

fbt::rfs4_grant_delegation:entry
{
        this->path = stringof(args[1]->rs_finfo->rf_vp->v_path);
        this->client = args[1]->rs_owner->ro_client->rc_clientid;
        this->type = deleg[arg0]!= NULL? deleg[arg0]: "<?>";
            printf("%-21Y%-20s%-8s%s\n", walltimestamp, "Grant Delegation",
        this->type, this->path);
}

fbt::rfs4_recall_deleg:entry
{
        this->path = stringof(args[0]->rf_vp->v_path);
        printf("%-21Y%-20s%-8s%s\n", walltimestamp, "Recall Delegation",
            ".", this->path);
}

fbt::rfs4_deleg_state_expiry:entry
{
        this->dsp = (rfs4_deleg_state_t *)arg0;
        this->path = stringof(this->dsp->rds_finfo->rf_vp->v_path);
        printf("%-21Y%-20s%-8s%s\n", walltimestamp, "Delegation Expiry",
            ".", this->path);
}
