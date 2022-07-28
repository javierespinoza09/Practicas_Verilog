`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.11.2021 20:24:40
// Design Name: 
// Module Name: ROM_inst
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//modificar el nombre del archivo de memoria
//agregar el archivo de memoria como ARCHIVO DE DISEÑO!!

//EL ARCHIVO DE MEMORIA SE ESCRIBE EN HEXADECIMAL LINEA POR LINEA
module ROM_inst(
output [31:0]douta, //32 bits
input [8:0] addra, //512 instrucciones
input clka,
input rsta
    );
    
    
    // xpm_memory_sprom: Single Port ROM
// Xilinx Parameterized Macro, version 2021.2
xpm_memory_sprom #(
.ADDR_WIDTH_A(9), // DECIMAL
.AUTO_SLEEP_TIME(0), // DECIMAL
.CASCADE_HEIGHT(0), // DECIMAL
.ECC_MODE("no_ecc"), // String
.MEMORY_INIT_FILE("memoria.mem"), // String
.MEMORY_INIT_PARAM("0"), // String
.MEMORY_OPTIMIZATION("true"), // String
.MEMORY_PRIMITIVE("auto"), // String
.MEMORY_SIZE(16384), // DECIMAL
.MESSAGE_CONTROL(0), // DECIMAL
.READ_DATA_WIDTH_A(32), // DECIMAL
.READ_LATENCY_A(0), // DECIMAL
.READ_RESET_VALUE_A("0"), // String
.RST_MODE_A("SYNC"), // String
.SIM_ASSERT_CHK(0), // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
.USE_MEM_INIT(1), // DECIMAL
.USE_MEM_INIT_MMI(0), // DECIMAL
.WAKEUP_TIME("disable_sleep") // String
)
xpm_memory_sprom_inst (
.dbiterra(dbiterra), // 1-bit output: Leave open.
.douta(douta), // READ_DATA_WIDTH_A-bit output: Data output for port A read operations.
.sbiterra(sbiterra), // 1-bit output: Leave open.
.addra(addra), // ADDR_WIDTH_A-bit input: Address for port A read operations.
.clka(clka), // 1-bit input: Clock signal for port A.
.ena(1'b1), // 1-bit input: Memory enable signal for port A. Must be high on clock
// cycles when read operations are initiated. Pipelined internally.
.injectdbiterra(injectdbiterra), // 1-bit input: Do not change from the provided value.
.injectsbiterra(injectsbiterra), // 1-bit input: Do not change from the provided value.
.regcea(regcea), // 1-bit input: Do not change from the provided value.
.rsta(rsta), // 1-bit input: Reset signal for the final port A output register stage.
// Synchronously resets output port douta to the value specified by
// parameter READ_RESET_VALUE_A.
.sleep(1'b0) // 1-bit input: sleep signal to enable the dynamic power saving feature.
);
// End of xpm_memory_sprom_inst instantiation

endmodule
