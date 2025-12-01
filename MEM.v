`timescale 1ns/1ns
module MEM (
    input clk,
    input reg_escribir_MEM,
    input mem_a_reg_MEM,
    input mem_escribir_MEM,
    input mem_leer_MEM,
    
    input [31:0] resultado_alu_MEM,     // Dirección para LW/SW
    input [31:0] dr2_forward_MEM,       // Dato a escribir en SW
    input [4:0]  registro_destino_MEM,  // Registro a escribir en WB

    // ---- Salida hacia WB ----
    output [31:0] write_data_WB,        // Dato final para escribir al banco
    output [4:0]  rd_WB,                // Número de registro destino
    output reg_write_WB                 // Señal para escribir en banco
);


    wire [31:0] dato_leido;

    memoria_datos mem_data (
        .clk(clk),
        .mem_escribir(mem_escribir_MEM),
        .mem_leer(mem_leer_MEM),
        .direccion(resultado_alu_MEM),
        .dato_escribir(dr2_forward_MEM),
        .dato_leer(dato_leido)
    );


    mux_memtoreg mux_wb (
        .alu_result(resultado_alu_MEM),
        .mem_data(dato_leido),
        .mem_a_reg(mem_a_reg_MEM),
        .write_data(write_data_WB)
    );

    assign rd_WB       = registro_destino_MEM;
    assign reg_write_WB = reg_escribir_MEM;

endmodule
