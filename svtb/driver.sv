class driver;

    virtual gpio_if vif;
    mailbox #(transaction) gen2drv;
    event drv_trigger;

    function new(virtual gpio_if vif, 
                 mailbox #(transaction) gen2drv,
                 event drv_trigger);
        this.vif         = vif;
        this.gen2drv     = gen2drv;
        this.drv_trigger = drv_trigger;
    endfunction

       task reset();
        vif.cb.reset            <= 1;
        vif.cb.dir              <= 2'b00;
        vif.cb.out_data         <= 2'b00;
        vif.cb.interrupt_enable <= 2'b00;
        vif.cb.clear            <= 2'b00;
        vif.cb.tb_drive_en      <= 2'b00;   
        vif.cb.tb_drive_data    <= 2'b00;
        repeat(5) @(vif.cb);
        vif.cb.reset <= 0;
        repeat(2) @(vif.cb);
        $display("[DRV] Reset Done");
    endtask

    task drive(transaction txn);
        @(vif.cb);

        vif.cb.dir              <= txn.dir;
        vif.cb.out_data         <= txn.out_data;
        vif.cb.interrupt_enable <= txn.interrupt_enable;
        vif.cb.clear            <= txn.clear;

         for (int i = 0; i < 2; i++) begin
            if (txn.dir[i] == 1'b0) begin
                // Input mode → DUT will float → TB drives
                vif.cb.tb_drive_en[i]   <= 1'b1;
                vif.cb.tb_drive_data[i] <= txn.gpio_in_value[i];
            end else begin
                // Output mode → DUT drives → TB stays silent
                vif.cb.tb_drive_en[i]   <= 1'b0;
            end
        end
    
        @(vif.cb);          
        -> drv_trigger;     
        repeat(3) @(vif.cb); 
    endtask

    task run();
        transaction txn;
        forever begin
            gen2drv.get(txn);
            drive(txn);
        end
    endtask

endclass