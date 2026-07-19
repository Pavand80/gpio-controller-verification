module gpio_controller (
    input  logic        clk,
    input  logic        reset,
    input  logic [1:0]  dir,
    input  logic [1:0]  out_data,
    input  logic [1:0]  interrupt_enable,
    input  logic [1:0]  clear,
    inout  wire  [1:0]  gpio_pin,          
    output logic [1:0]  interrupt_status,
    output logic        irq
);

    logic [1:0] direction_reg;
    logic [1:0] output_reg;
    logic [1:0] current_sample;
    logic [1:0] previous_sample;
    logic [1:0] edge_detect;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) direction_reg <= 2'b00;
        else       direction_reg <= dir;
    end

    always_ff @(posedge clk or posedge reset) begin
        if (reset) output_reg <= 2'b00;
        else       output_reg <= out_data;
    end

 
    assign gpio_pin[0] = direction_reg[0] ? output_reg[0] : 1'bz;
    assign gpio_pin[1] = direction_reg[1] ? output_reg[1] : 1'bz;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_sample  <= 2'b00;
            previous_sample <= 2'b00;
        end else begin
            previous_sample <= current_sample;
            current_sample  <= gpio_pin;  
        end
    end

    assign edge_detect = current_sample ^ previous_sample;

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

    assign irq = |interrupt_status;

endmodule