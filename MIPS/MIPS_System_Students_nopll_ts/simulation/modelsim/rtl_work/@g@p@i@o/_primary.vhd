library verilog;
use verilog.vl_types.all;
entity GPIO is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        CS_N            : in     vl_logic;
        RD_N            : in     vl_logic;
        WR_N            : in     vl_logic;
        Addr            : in     vl_logic_vector(11 downto 0);
        DataIn          : in     vl_logic_vector(31 downto 0);
        KEY             : in     vl_logic_vector(3 downto 1);
        SW              : in     vl_logic_vector(17 downto 0);
        DataOut         : out    vl_logic_vector(31 downto 0);
        Intr            : out    vl_logic;
        HEX7            : out    vl_logic_vector(6 downto 0);
        HEX6            : out    vl_logic_vector(6 downto 0);
        HEX5            : out    vl_logic_vector(6 downto 0);
        HEX4            : out    vl_logic_vector(6 downto 0);
        HEX3            : out    vl_logic_vector(6 downto 0);
        HEX2            : out    vl_logic_vector(6 downto 0);
        HEX1            : out    vl_logic_vector(6 downto 0);
        HEX0            : out    vl_logic_vector(6 downto 0);
        LEDR            : out    vl_logic_vector(17 downto 0);
        LEDG            : out    vl_logic_vector(8 downto 0)
    );
end GPIO;
