-- Gabriel Rocha Mariano da Silva 
-- Prova 2

library IEEE;
use IEEE. std_logic_1164.all;
use IEEE.numeric_std.all;

entity p2_grms is

	port
	(
--==================================================================
-- Componentes do FPGA
	
		signal CLOCK_50	             : in  std_logic;
		signal SW                      : in  std_logic_vector (17 downto 0);
		signal KEY                     : in  std_logic_vector (3 downto 0) ;
		signal LEDG                    : out std_logic_vector (8 downto 0) ;
		signal LEDR                    : out std_logic_vector (17 downto 0);
		signal HEX7, HEX6, HEX5, HEX4,
				 HEX3, HEX2, HEX1, HEX0  : out std_logic_vector (6 downto 0) ;
	
--=================================================================================
-- Memória SDRAM	

		signal DRAM_CLK    : out std_logic;
		signal DRAM_ADDR   : out std_logic_vector (11 downto 0);
		signal DRAM_BA		 : out std_logic_vector(1 downto 0);
		signal DRAM_CAS_N  : out   std_logic;
		signal DRAM_CKE    : out   std_logic;                                        
		signal DRAM_CS_N   : out   std_logic;                                        
		signal DRAM_DQ     : inout std_logic_vector(15 downto 0) := (others => 'X'); 
		signal DRAM_DQM    : out   std_logic_vector(1 downto 0);                    
		signal DRAM_RAS_N  : out   std_logic;                                        
		signal DRAM_WE_N   : out   std_logic;     

--=================================================================================	
-- LCD
		signal LCD_RS            : out   std_logic;                                        
		signal LCD_RW            : out   std_logic;                                        
		signal LCD_DATA          : inout std_logic_vector(7 downto 0)  := (others => 'X'); 
		signal LCD_EN            : out   std_logic;                                         
		signal LCD_ON            : out   std_logic;
		signal LCD_BLON          : out   std_logic
		
	);
--=================================================================================
	
end entity;




architecture logica of p2_grms is

	
--====================================================================================
-- Jogar aqui o processador criado no QSYS!!
	
component p2_grms_qsys is
	port (
		clk_clk                              : in    std_logic                     := 'X';             -- clk
		reset_reset_n                        : in    std_logic                     := 'X';             -- reset_n
		pi_grms_external_connection_export   : out   std_logic_vector(3 downto 0);                     -- export     Display HEX0 convertido por VHDL 
		ph_grms_external_connection_export   : out   std_logic_vector(3 downto 0);                     -- export     Display HEX2 convertido por VHDL 
		pg_grms_external_connection_export   : out   std_logic_vector(6 downto 0);                     -- export     Display HEX4 convertido por codigo C
		pf_grms_external_connection_export   : out   std_logic_vector(6 downto 0);                     -- export     Display HEX6 convertido por codigo C
		pe_grms_external_connection_export   : out   std_logic_vector(7 downto 0);                     -- export     LEDR
		pd_grms_external_connection_export   : out   std_logic_vector(7 downto 0);                     -- export     LEDG
		pc_grms_external_connection_export   : out   std_logic;                                        -- export     TX
		pb_grms_external_connection_export   : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- export     KEY
		pa_grms_external_connection_export   : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- export     SW
		lcd_16207_grms_external_RS           : out   std_logic;                                        -- RS
		lcd_16207_grms_external_RW           : out   std_logic;                                        -- RW
		lcd_16207_grms_external_data         : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- data
		lcd_16207_grms_external_E            : out   std_logic;                                        -- E
		new_sdram_controller_grms_wire_addr  : out   std_logic_vector(11 downto 0);                    -- addr
		new_sdram_controller_grms_wire_ba    : out   std_logic_vector(1 downto 0);                     -- ba
		new_sdram_controller_grms_wire_cas_n : out   std_logic;                                        -- cas_n
		new_sdram_controller_grms_wire_cke   : out   std_logic;                                        -- cke
		new_sdram_controller_grms_wire_cs_n  : out   std_logic;                                        -- cs_n
		new_sdram_controller_grms_wire_dq    : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
		new_sdram_controller_grms_wire_dqm   : out   std_logic_vector(1 downto 0);                     -- dqm
		new_sdram_controller_grms_wire_ras_n : out   std_logic;                                        -- ras_n
		new_sdram_controller_grms_wire_we_n  : out   std_logic                                         -- we_n
	);
end component p2_grms_qsys;



--========================================================================================
-- Controlador serial
	
component controlador_serial_usart is
port (

	signal clk_ref                       : in std_logic; 
	signal rx                            : in std_logic;
	signal display1, display3, 
	       display5, display7            : out std_logic_vector (6 downto 0)
			 
);
end component controlador_serial_usart;

	
--=========================================================================================	
-- Sinais intermediários

signal display2emVHDL, display0emVHDL : std_logic_vector(3 downto 0);  

signal display6emC, display4emC : std_logic_vector (6 downto 0); 

signal display7, display5,
	    display3, display2, 
		 display1, display0       : std_logic_vector (6 downto 0);
		 
signal tx : std_logic := '1';	
	
--============================================================================================
-- Conversor de 7 Seg	
	
component conv_7seg is 
port (

signal en      : in std_logic;
signal dado    : in std_logic_vector (3 downto 0);
signal display : out std_logic_vector (6 downto 0)

);
end component conv_7seg;

--=============================================================================================
	
	
	
	begin 
	
	HEX0 <= not display0;
	HEX1 <= not display1;
	HEX2 <= not display2;
	HEX3 <= not display3;
	HEX4 <= not display4emC;
	HEX5 <= not display5;
	HEX6 <= not display6emC;
	HEX7 <= not display7;
	
	
	LCD_ON   <= SW(16);
	LCD_BLON <= SW(15);

	
	DRAM_CLK <=  CLOCK_50;

	
	
	
--===================================================================================================================
-- Mapeamento das portas do top level		
		

x_display2: conv_7seg port map('1', display2emVHDL, display2); -- display controlado direto do processador com conv
x_display0: conv_7seg port map('1', display0emVHDL, display0);	-- display controlado direto do processador com conv

	
x_processador : p2_grms_qsys port map(
										
CLOCK_50,
SW(17),
display0emVHDL,
display2emVHDL,
display4emC,
display6emC,
LEDR(7 downto 0),
LEDG(7 downto 0),
tx,
KEY(3 downto 0),
SW(7 downto 0),
LCD_RS,
LCD_RW,
LCD_DATA,
LCD_EN,
DRAM_ADDR,
DRAM_BA,
DRAM_CAS_N,
DRAM_CKE,
DRAM_CS_N,
DRAM_DQ,
DRAM_DQM,
DRAM_RAS_N,
DRAM_WE_N
																										
);	
	
x_usart : controlador_serial_usart port map(

CLOCK_50, 
tx, 
display7, 
display5, 
display3,  
display1
					                     
);				
															
											
end architecture logica;