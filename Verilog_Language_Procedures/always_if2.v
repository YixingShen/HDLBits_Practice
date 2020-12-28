//always @(*) begin
//    if (cpu_overheated)
//       shut_off_computer = 1;
//end
//
//always @(*) begin
//    if (~arrived)
//       keep_driving = ~gas_tank_empty;
//end

//Warning (10240): Verilog HDL Always Construct warning at top_module.v(10): inferring latch(es) for variable "shut_off_computer", which holds its previous value in one or more paths through the always construct File: /var/www/verilog/work/vlgF6zPLY_dir/top_module.v Line: 10
//Warning (10240): Verilog HDL Always Construct warning at top_module.v(15): inferring latch(es) for variable "keep_driving", which holds its previous value in one or more paths through the always construct File: /var/www/verilog/work/vlgF6zPLY_dir/top_module.v Line: 15

//The following code contains incorrect behaviour that creates a latch. 
//Fix the bugs so that you will shut off the computer only if it's really overheated, 
//and stop driving if you've arrived at your destination or you need to refuel.

// synthesis verilog_input_version verilog_2001
module top_module (
    input      cpu_overheated,
    output reg shut_off_computer,
    input      arrived,
    input      gas_tank_empty,
    output reg keep_driving  );//

    always @(*) begin
        if (cpu_overheated)
           shut_off_computer = 1;
        else
           shut_off_computer = 0;
    end

    always @(*) begin
        if (~arrived)
            keep_driving = ~gas_tank_empty;
        else
            keep_driving = 0;
    end
endmodule