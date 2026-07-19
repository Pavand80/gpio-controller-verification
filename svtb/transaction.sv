class transaction;

    // Stimulus — inputs to DUT
    rand logic [1:0] dir;
    rand logic [1:0] out_data;
    rand logic [1:0] gpio_in_value;       // value driver pushes when dir=0 (input mode)
    rand logic [1:0] interrupt_enable;
    rand logic [1:0] clear;

    // Observed — outputs from DUT
    logic [1:0] gpio_pin_observed;        // what monitor reads on the shared pin
    logic [1:0] interrupt_status;
    logic        irq;

    // Constraints
    constraint valid_dir {
        dir inside {2'b00, 2'b01, 2'b10, 2'b11};
    }

    constraint valid_interrupt {
        interrupt_enable inside {2'b00, 2'b01, 2'b10, 2'b11};
    }

    // Deep Copy
    function transaction copy();
        copy = new();
        copy.dir               = this.dir;
        copy.out_data          = this.out_data;
        copy.gpio_in_value     = this.gpio_in_value;
        copy.interrupt_enable  = this.interrupt_enable;
        copy.clear             = this.clear;
        copy.gpio_pin_observed = this.gpio_pin_observed;
        copy.interrupt_status  = this.interrupt_status;
        copy.irq               = this.irq;
    endfunction

    // Print — for debugging
    function void print(string tag);
        $display("[%s] dir=%b out_data=%b gpio_in_value=%b int_en=%b clear=%b | gpio_pin=%b int_status=%b irq=%b",
            tag, dir, out_data, gpio_in_value, interrupt_enable, clear,
            gpio_pin_observed, interrupt_status, irq);
    endfunction

endclass