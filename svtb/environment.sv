`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;

    generator  gen;
    driver     drv;
    monitor    mon;
    scoreboard scb;

    mailbox #(transaction) gen2drv;
    mailbox #(transaction) mon2scb;

    event drv_trigger;

    virtual gpio_if vif;

    function new(virtual gpio_if vif, int count = 5);
        this.vif = vif;

        gen2drv = new();
        mon2scb = new();

        gen = new(gen2drv, count);
        drv = new(vif, gen2drv, drv_trigger);
        mon = new(vif, mon2scb, drv_trigger);
        scb = new(mon2scb);
    endfunction

    task run();
        fork
            gen.run();
            drv.run();
            mon.run(gen.count);
            scb.run(gen.count);
        join_none
    endtask

    function void report();
        scb.report();
    endfunction

endclass