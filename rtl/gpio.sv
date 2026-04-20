// Code your design here
module gpio_controller (
    input  logic        clk,
    input  logic        reset,
    input  logic [1:0]  dir,
    input  logic [1:0]  out_data,
    input  logic [1:0]  gpio_in,
    input  logic [1:0]  interrupt_enable,
    input  logic [1:0]  clear,
    output logic [1:0]  gpio_out,
    output logic [1:0]  interrupt_status,
    output logic        irq
);

    // Internal Signals
    logic [1:0] direction_reg;
    logic [1:0] output_reg;
    logic [1:0] current_sample;
    logic [1:0] previous_sample;
    logic [1:0] edge_detect;

    // ----------------------------------------
    // BLOCK 1 : GPIO_DATA_PATH
    // ----------------------------------------

    // Direction Register
    always_ff @(posedge clk or posedge reset) begin
        if (reset) direction_reg <= 2'b00;
        else        direction_reg <= dir;
    end

    // Output Data Register
    always_ff @(posedge clk or posedge reset) begin
        if (reset) output_reg <= 2'b00;
        else        output_reg <= out_data;
    end

    // Output Driver — combinational
    always_comb begin
        for (int i = 0; i < 2; i++) begin
            gpio_out[i] = direction_reg[i] ? output_reg[i] : 1'b0;
        end
    end

    // Input Sampler
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_sample  <= 2'b00;
            previous_sample <= 2'b00;
        end else begin
            previous_sample <= current_sample;
            current_sample  <= gpio_in;
        end
    end

    // ----------------------------------------
    // BLOCK 2 : GPIO_INTERRUPT_CTRL
    // ----------------------------------------

    // Edge Detection — XOR current and previous
    assign edge_detect = current_sample ^ previous_sample;

    // Interrupt Status Register
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            interrupt_status <= 2'b00;
        else begin
            for (int i = 0; i < 2; i++) begin
                if (clear[i])
                    interrupt_status[i] <= 1'b0;
                else if (edge_detect[i] && interrupt_enable[i])
                    interrupt_status[i] <= 1'b1;
            end
        end
    end

    // IRQ — Global interrupt
    assign irq = |interrupt_status;

endmodule