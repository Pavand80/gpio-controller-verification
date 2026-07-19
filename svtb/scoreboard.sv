class scoreboard;

    mailbox #(transaction) mon2scb;
    int pass_count = 0;
    int fail_count = 0;

    // State variables
    logic [1:0] direction_reg    = 2'b00;
    logic [1:0] output_reg       = 2'b00;
    logic [1:0] current_sample   = 2'b00;
    logic [1:0] previous_sample  = 2'b00;
    logic [1:0] interrupt_status = 2'b00;

    function new(mailbox #(transaction) mon2scb);
        this.mon2scb = mon2scb;
    endfunction

    // Reference Model
    function void predict(
        input  logic [1:0] dir,
        input  logic [1:0] out_data,
        input  logic [1:0] gpio_in_value,
        input  logic [1:0] interrupt_enable,
        input  logic [1:0] clear,
        output logic [1:0] exp_gpio_pin,
        output logic [1:0] exp_interrupt_status,
        output logic       exp_irq
    );
        logic [1:0] edge_detect;

        direction_reg = dir;
        output_reg    = out_data;

        previous_sample = current_sample;

        // ---- KEY NEW LOGIC ----
        // Expected pin value depends on direction, per pin
        for (int i = 0; i < 2; i++) begin
            if (direction_reg[i])
                exp_gpio_pin[i] = output_reg[i];     // DUT drives — output mode
            else
                exp_gpio_pin[i] = gpio_in_value[i];  // TB drives — input mode
        end
        // ------------------------

        // current_sample mirrors what DUT itself would have sampled
        current_sample = exp_gpio_pin;

        // Edge detection — same as before
        edge_detect = current_sample ^ previous_sample;

        for (int i = 0; i < 2; i++) begin
            if (clear[i])
                interrupt_status[i] = 1'b0;
            else if (edge_detect[i] && interrupt_enable[i])
                interrupt_status[i] = 1'b1;
        end

        exp_interrupt_status = interrupt_status;
        exp_irq               = |interrupt_status;

    endfunction

    // Check
    task check(transaction txn);
        logic [1:0] exp_gpio_pin;
        logic [1:0] exp_interrupt_status;
        logic       exp_irq;

        predict(
            txn.dir, txn.out_data, txn.gpio_in_value,
            txn.interrupt_enable, txn.clear,
            exp_gpio_pin, exp_interrupt_status, exp_irq
        );

        if (txn.gpio_pin_observed === exp_gpio_pin &&
            txn.interrupt_status  === exp_interrupt_status &&
            txn.irq                === exp_irq) begin
            $display("[SCB] PASS | gpio_pin=%b int_status=%b irq=%b",
                txn.gpio_pin_observed, txn.interrupt_status, txn.irq);
            pass_count++;
        end else begin
            $display("[SCB] FAIL");
            $display("     Expected -> gpio_pin=%b int_status=%b irq=%b",
                exp_gpio_pin, exp_interrupt_status, exp_irq);
            $display("     Actual   -> gpio_pin=%b int_status=%b irq=%b",
                txn.gpio_pin_observed, txn.interrupt_status, txn.irq);
            fail_count++;
        end
    endtask

    task run(int count);
        transaction txn;
        repeat(count) begin
            mon2scb.get(txn);
            check(txn);
        end
    endtask

    function void report();
        $display("-----------------------------");
        $display("   SIMULATION REPORT");
        $display("-----------------------------");
        $display("   PASS : %0d", pass_count);
        $display("   FAIL : %0d", fail_count);
        $display("   TOTAL: %0d", pass_count + fail_count);
        if (fail_count == 0)
            $display("   STATUS : ALL TESTS PASSED");
        else
            $display("   STATUS : SOME TESTS FAILED");
        $display("-----------------------------");
    endfunction

endclass