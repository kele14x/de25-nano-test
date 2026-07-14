// Reset Release IP implementation for Agilex 5.
// ninit_done remains high until the whole FPGA fabric enters user mode.
module altera_s10_user_rst_clkgate (
    output logic ninit_done
);

    altera_agilex_config_reset_release_endpoint reset_release_endpoint (
        .conf_reset(ninit_done)
    );

endmodule
