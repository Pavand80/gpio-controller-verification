`include "environment.sv"

class test;

    environment env;
    virtual gpio_if vif;

    function new(virtual gpio_if vif, int count = 5);
        this.vif = vif;
        env = new(vif, count);
    endfunction

    task run();
        env.drv.reset();
        env.run();
        #10000;
        env.report();
    endtask

endclass