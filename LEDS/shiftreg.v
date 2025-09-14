//SHIFTREG 
module shiftreg
(
parameter NB_LED = 4,
)
(
    output [NB_LED-1:0] o_led,

    input               i_valid,
    input               i_reset,
    input               clock
);

    reg [NB_LED -   1   :   0] shiftreg;

    always @(posedge clock) begin
        if (i_reset) begin
            shiftreg <= {{NB_LED-1{1'b0},1b'1}};
        end
        else if (i_valid0)begin
            //OPTION 1
            shiftreg <= shiftreg << 1;
            shiftreg[0] <= shiftreg[NB_LED-1];
            //OPTION 2
            shiftreg <= {shiftreg[NB_LED-2:0], shiftreg[NB_LED-1]};
            shiftreg <= {shiftreg, shiftreg[NB_LED-1]};
        end
    end

    assign o_led = r_led;


endmodule