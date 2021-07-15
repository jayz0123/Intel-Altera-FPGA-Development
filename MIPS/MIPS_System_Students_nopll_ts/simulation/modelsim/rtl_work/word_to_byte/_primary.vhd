library verilog;
use verilog.vl_types.all;
entity word_to_byte is
    port(
        a               : in     vl_logic_vector(31 downto 0);
        whichbyte       : in     vl_logic_vector(1 downto 0);
        loadbyte        : in     vl_logic;
        y               : out    vl_logic_vector(31 downto 0)
    );
end word_to_byte;
