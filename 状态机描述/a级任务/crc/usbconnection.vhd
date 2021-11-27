library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity usbconnection is
    port(
        clk:in std_logic;
        din:in std_logic_vector(7 downto 0);
        nrxf:in std_logic;
        nrd:out std_logic;
        ntxe:in std_logic;
        wr:out std_logic;
        dout:out std_logic_vector(7 downto 0)
    );
end USBconnection;

architecture USBconnection of USBconnection is
    type state is(wait_nrxf_low, set_nrd_low, latch_data_from_host, wait_ntxe_low, set_wr_high, send_data_host);
    signal current_state, next_state: state;
    signal o:std_logic_vector(4 downto 0);
    signal input:std_logic_vector(13 downto 0);
    signal p:std_logic_vector(5 downto 0);
    signal a_in:std_logic_vector(8 downto 0);
    signal b_out:std_logic_vector(4 downto 0);
    begin
        process(clk)
        begin
            if clk'event and clk='1' then
                current_state<=next_state;
            end if;
        end process;
        process(clk)
        begin
            if clk'event and clk='1' then
                case current_state is
                    when wait_nrxf_low =>
                        nrd<='1';
                        wr <='0';
                    if nrxf='0' then
                        next_state<=set_nrd_low;
                    else next_state <= wait_nrxf_low;
                    end if;
                    when set_nrd_low =>
                        nrd <= '0';                          --nrd变为0，上位机输出数据
                        wr <= '0';
                    next_state <= latch_data_from_host;
                when latch_data_from_host   =>
                    nrd <= '0';
                    wr <= '0';
                    a_in(7 downto 0) <= din(7 downto 0);     --数据进行接收
                    next_state <= wait_ntxe_low;
                when wait_ntxe_low =>
                    nrd <= '1';
                    wr <= '0';
                    if ntxe = '0' then                       --当ntex变为0时，可以发送数�?
                        next_state <= set_wr_high;
                    else next_state <= wait_ntxe_low;
                    end if;
                when set_wr_high =>
                    nrd <= '1';
                    wr <= '1';                               --wr输出1，发送数据到上位�?
                    next_state <= send_data_host;
                when send_data_host =>
                    nrd <= '1';
                    wr <= '1';
                    dout(4 downto 0) <= o(4 downto 0);
                    dout(7 downto 5) <= "000";    --数据进行发�?
                    next_state <= wait_nrxf_low;
                when others =>
                    nrd <= '1';
                    wr <= '1';
                    dout <= "ZZZZZZZZ";
                    next_state <= wait_nrxf_low;
                end case;
            end if;
            end process;
            process(clk)
                variable d:std_logic_vector(5 downto 0);
                variable c:std_logic_vector(4 downto 0);
            begin
                    p<="110101";
                    c:="00000";
                input<=a_in&c;
                d(5):=input(12);
                d(4):=input(11);
                d(3):=input(10);
                d(2):=input(9);
                d(1):=input(8);
                d(0):=input(7);
                for i in 7 downto 1 loop
                    if d(5)='0' then
                        for j in 4 downto 0 loop
                            c(j):=d(j) xor '0';
                        end loop;
                    else
                        for j in 4 downto 0 loop
                            c(j):=d(j) xor p(j);
                        end loop;
                    end if;
                    d:=c&input(i-1);
                end loop;
                if d(5)='0' then
                    for j in 4 downto 0 loop
                        c(j):=d(j) xor '0';
                    end loop;
                else
                    for j in 4 downto 0 loop
                        c(j):=d(j) xor p(j);
                    end loop;
                end if;
                o<=c;
                b_out<=o;
            end process;
        end USBconnection;