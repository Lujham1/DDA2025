
module count
(
    parameter NB_SW = 3,
    parameter NB_COUNTER = 32
)

(

    output      o_valid,

    input [2:0] i_sw   ,
    input       i_reset,
    input       clock
);


    //LOCALPARAM NB_COUNTER si lo bajo mucho, el tiempo que esta prendido el led baja mucho entonces no lo veo 
    //entonces subo a 32 por ej para poder ver comportamiento correcto y despues bajo a 12 por ej para poder sintetisar y ver los tiempos en la herramientanta
    localparam R0 = (2**(NB_COUNTER-10))-1;
    localparam R1 = (2**(NB_COUNTER-8))-1;
    localparam R2 = (2**(NB_COUNTER-6))-1;
    localparam R3 = (2**(NB_COUNTER-4))-1;

    //VARS
    wire [NB_COUNTER -1 : 0] limit ;
    reg [NB_COUNTER -1 : 0] counter;
    reg                     valid  ;      
    assign  limit = (i_sw[2:1] == 2'b00) ? R0   :
                    (i_sw[2:1] == 2'b01) ? R1   :
                    (i_sw[2:1] == 2'b10) ? R2   : R3;

    always @(posedge clock) begin: 
        if (i_reset) begin
            counter <= {NB_COUNTER{1'b0}};
        end
        else if (i_sw[0]) begin
                if (counter >= limit) begin
                    counter <= {NB_COUNTER{1'b0}};
            end
                else begin
                    counter <= counter +  {NB_COUNTER-1{1'b0}, 1'b1};
                    valid   <= 1'b0;
                end
            end
    end
    else begin
        counter <= counter;
        valid <= valid;
    end

    assign o_valid = valid;
     

                    

endmodule