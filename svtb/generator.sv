class generator;

    mailbox #(transaction) gen2drv;
    int count;

    function new(mailbox #(transaction) gen2drv, int count);
        this.gen2drv = gen2drv;
        this.count   = count;
    endfunction

    task run();
        transaction txn;

        repeat(count) begin
            txn = new();

            if(!txn.randomize())
                $fatal(1, "[GEN] Randomization Failed!");

            gen2drv.put(txn.copy());
        end

        $display("[GEN] Done - %0d transactions generated", count);
    endtask

endclass