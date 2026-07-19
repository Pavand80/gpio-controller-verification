`include "interface.sv"
`include "test.sv"

module tb_top;

    logic clk;
    initial clk = 0;
    always #5 clk = ~clk;

    // Interface instantiation
    gpio_if vif(clk);

    // DUT instantiation — note ONLY gpio_pin now, no separate in/out
    gpio_controller dut (
        .clk              (clk),
        .reset            (vif.reset),
        .dir              (vif.dir),
        .out_data         (vif.out_data),
        .interrupt_enable (vif.interrupt_enable),
        .clear            (vif.clear),
        .gpio_pin         (vif.gpio_pin),       // ← shared bidirectional pin
        .interrupt_status (vif.interrupt_status),
        .irq              (vif.irq)
    );

    test t;

    initial begin
        t = new(vif, 5);
        t.run();
        $finish;
    end

    initial begin
        $dumpfile("gpio_tb.vcd");
        $dumpvars(0, tb_top);
    end

endmodule