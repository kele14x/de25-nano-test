// Minimal DE25-Nano LED blinker.
//
// CLOCK0_50 is a 50 MHz fabric clock.  The board LEDs are active low, so
// LEDR[0] is inverted below; it is lit while blink is high.
module de25_nano_test_top (
    input  logic       CLOCK0_50,
    output logic [7:0] LEDR
);

    // Toggle every 25,000,000 clock cycles: LEDR[0] completes one on/off
    // cycle each second.
    localparam int unsigned HALF_PERIOD_CYCLES = 25_000_000;
    localparam int unsigned COUNTER_WIDTH = $clog2(HALF_PERIOD_CYCLES);

    logic [COUNTER_WIDTH-1:0] counter;
    logic                     blink;
    logic                     ninit_done;

    // Required on Agilex 5: holds this logic in reset until the complete
    // fabric has entered user mode. nINIT_DONE is an active-high reset.
    altera_s10_user_rst_clkgate reset_release (
        .ninit_done(ninit_done)
    );

    always_ff @(posedge CLOCK0_50) begin
        if (ninit_done) begin
            counter <= '0;
            blink   <= 1'b0;
        end else if (counter == HALF_PERIOD_CYCLES - 1) begin
            counter <= '0;
            blink   <= ~blink;
        end else begin
            counter <= counter + 1'b1;
        end
    end

    // LEDR[7:1] are kept off. LEDs turn on when their FPGA output is low.
    always_comb begin
        LEDR      = '1;
        LEDR[0]   = ~blink;
    end

endmodule
