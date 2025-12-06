
module top
#(
    parameter NB_LED = 4,
    parameter NB_SW  = 4
    parameter NB_COUNTER = 32
)
(
    output [NB_LED - 1 : 0] o_led  ,
    output [NB_LED - 1 : 0] o_led_b,
    output [NB_LED - 1 : 0] o_led_g,

    input [NB_SW - 1 : 0] i_sw    ,
    input                 i_reset ,
    input                 clock   
);

    wire                  connected_c2sf;
    wire [NB_LED - 1 : 0] connected_led ;
    count
    #(
        .NB_SW      (NB_SW - 1 ),   
        .NB_COUNTER (NB_COUNTER)
    )
    u_count(
        .o_valid (connected_c2sf    ),
        .i_sw    (i_sw[NB_SW -2 : 0]),
        .i_reset (~i_reset           ),
        .clock   (clock          )                      
    );
    shiftreg
    #(
        .NB_LED (NB_LED )
    )
    u_shiftreg(
        .o_led  (connected_led  ),
        .i_valid(connected_c2sf ),
        .i_reset(i_reset        ),
        .clock  (clock          )
    );

    assign o_led   = connected_led ;
    assign o_led_b = (i_sw[NB_SW -1]) ? connected_led : {NB_LED{1'b0}} ;
    assign o_led_g = (i_sw[NB_SW -1]) ? {NB_LED{1'b0}} : connected_led ;


endmodule