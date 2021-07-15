library verilog;
use verilog.vl_types.all;
entity ClockBlk_vlg_check_tst is
    port(
        c0              : in     vl_logic;
        c1              : in     vl_logic;
        c2              : in     vl_logic;
        locked          : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end ClockBlk_vlg_check_tst;
