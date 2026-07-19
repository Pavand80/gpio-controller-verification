class monitor;

    virtual gpio_if vif;
    mailbox #(transaction) mon2scb;
    event drv_trigger;

    function new(virtual gpio_if vif,
                 mailbox #(transaction) mon2scb,
                 event drv_trigger);
        this.vif         = vif;
        this.mon2scb     = mon2scb;
        this.drv_trigger = drv_trigger;
    endfunction

    task run(int count);
        transaction txn;

        repeat(count) begin
            txn = new();

            // Wait for driver to signal
            @(drv_trigger);

            // Capture inputs side
            txn.dir              = vif.cb.dir;
            txn.out_data         = vif.cb.out_data;
            txn.interrupt_enable = vif.cb.interrupt_enable;
            txn.clear            = vif.cb.clear;
            txn.gpio_in_value    = vif.cb.tb_drive_data;  // what TB pushed (if any)

            // Wait for DUT to respond
            repeat(2) @(vif.cb);

            // Capture outputs side — SAME shared pin
            txn.gpio_pin_observed = vif.cb.gpio_pin;
            txn.interrupt_status  = vif.cb.interrupt_status;
            txn.irq               = vif.cb.irq;

            txn.print("[MON]");
            mon2scb.put(txn);
        end
    endtask

endclass