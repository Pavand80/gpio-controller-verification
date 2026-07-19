interface gpio_if (input logic clk);
    wire [1:0] gpio_pin;
    logic        reset;
    logic [1:0]  dir;
    logic [1:0]  out_data;
    logic [1:0]  interrupt_enable;
    logic [1:0]  clear;
    logic [1:0]  interrupt_status;
    logic        irq;

    logic [1:0]  tb_drive_data;   
    logic [1:0]  tb_drive_en;     

    assign gpio_pin[0] = tb_drive_en[0] ? tb_drive_data[0] : 1'bz;
    assign gpio_pin[1] = tb_drive_en[1] ? tb_drive_data[1] : 1'bz;

    clocking cb @(posedge clk);
        default input #1 output #1;

        // Driver drives these
        output reset;
        output dir;
        output out_data;
        output interrupt_enable;
        output clear;
        output tb_drive_data;
        output tb_drive_en;

        // Monitor reads these
        input gpio_pin;
        input interrupt_status;
        input irq;
    endclocking

    modport TB (clocking cb, input clk);

endinterface