module ControlSPI (
input clk, rst, 
input [31:0] OUTControl,OUTDatos,
input MISO,
output reg WR2Control,WR2Datos,
output reg [31:0] IN2Control,IN2Datos,
output reg MOSI,SS,
output reg CLK

);

reg clear_ntx,rstc;
reg [7:0] Datos;
wire [7:0] Datosal;
reg bitin;
wire [2:0] cuenta;
wire rstcm,rstxm;
reg rstx;
reg load, ENcorrimiento;

wire lp,ln,CLK0;


assign rstcm=(rst)|rstc;
assign rstxm=(rst)|rstx;
contador8 C1(.clk(clk),.rst(rstcm),.cuenta(cuenta),.en(lp));

GeneradorCLKyPulsos G1(.clk(clk),.rst(rstxm),.CLK(CLK0),.lp(lp),.ln(ln));

reg_corrimiento r1(.rst(rst),.clk(clk),.en(lp&&(~rstcm)),.load(load),.datosload(Datos),.datos(Datosal),.bitin(bitin),.ln(ln));

parameter BITS_ESTADO = 3;
reg [BITS_ESTADO-1:0] state, next_state;

parameter ESTADO_Espera ='b000, ESTADO_bit0='b001, ESTADO_trans='b010, ESTADO_Suma='b011, ESTADO_Clear_ntx='b100,ESTADO_bit7='b101;

always @(posedge clk) begin
    if(rst) state <= ESTADO_Espera; 
    else state<=next_state;

end

always @(*) begin
    case(state)

	ESTADO_Espera: begin
		if(OUTControl[0]) next_state = ESTADO_bit0;
		else if (OUTControl[1]) next_state = ESTADO_Clear_ntx;
		else next_state = ESTADO_Espera;
    end
    ESTADO_bit0: begin
        if (lp) next_state = ESTADO_trans;
        else next_state = ESTADO_bit0;
    end          
          
    ESTADO_trans: begin
        if (cuenta<7)next_state = ESTADO_trans;
        else if (lp)begin 
        next_state =ESTADO_bit7;
        end
        else next_state=ESTADO_trans;
    end
    ESTADO_bit7: begin
    if (ln) next_state=ESTADO_Suma;
    else next_state=ESTADO_bit7;
    end
    
    ESTADO_Suma: begin
        next_state =ESTADO_Espera;
    end
    
    ESTADO_Clear_ntx: begin
        next_state =ESTADO_Espera;
    end
   
	default:
	   next_state = ESTADO_Espera;
    endcase
end


always @(*) begin
    
    IN2Datos [31:0]={22'b0000, Datosal};
    

    case(state)
	 ESTADO_Espera:	begin
			   MOSI = 0;
			   SS=1;
			   rstc=1;
			   rstx=1;
			   WR2Datos=0; WR2Control=0;
			   load=1;
			   Datos=OUTDatos [7:0];
			   IN2Control [31:0]=OUTControl[31:0];
			   CLK=0;
			
			   
	end 
			
	ESTADO_bit0: begin
	           MOSI=Datosal[0];
		       rstc=1;
		       load=0;
		       rstx=0;
		       IN2Control [31:0]=OUTControl[31:0];
		       SS=0;
		       CLK=CLK0;
	end	
	           	
    ESTADO_trans: begin
		       MOSI=Datosal[0];
		      bitin=MISO;
		      load=0;
		       WR2Datos=0;
		       SS=0;
		       rstc=0;
		       rstx=0;
		       IN2Control [31:0]=OUTControl[31:0];
		       CLK=CLK0;
		      
	end 
	ESTADO_bit7: begin
	           MOSI=Datosal[0];
		       bitin=MISO;
		       load=0;
		       WR2Datos=0;
		       SS=0;
		       rstc=1;
		       rstx=0;
		       IN2Control [31:0]=OUTControl[31:0];
		       CLK=0;
	end
	
	ESTADO_Suma: begin
	           IN2Control [31:0]={16'b0,OUTControl[15:8]+1,6'b0,OUTControl[1], 1'b0}; // IN2Control[15:8] = Transacciones 
	           
	           WR2Control=1;
	           WR2Datos=1;
	           
	           load=0;
	           rstc=1;
		       rstx=1;
		       SS=1;
		       CLK=0;
	end
	ESTADO_Clear_ntx: begin
	           IN2Control [31:0]={16'b0,8'b0,6'b0,1'b0, OUTControl[0]}; // IN2Control[1] = Clear_ntx
	           load=0;
	           WR2Control=1;
	           WR2Datos=0;
	           rstc=1;
		       rstx=1;
		       SS=1;
		       CLK=CLK0;
	end

    endcase
end



endmodule
