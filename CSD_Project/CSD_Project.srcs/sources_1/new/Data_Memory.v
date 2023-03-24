`define filename "./test/data.o"
`define simulation_time #160

module Data_Memory(
 input clk,
 input [31:0]   mem_access_addr,
 input [31:0]   mem_write_data,
 input mem_write_en,
 input mem_read,
 
 output [31:0]   mem_read_data
);

reg [31:0] memory [7:0];
integer f;
wire [2:0] ram_addr=mem_access_addr[2:0];
initial
 begin
  $readmemb("./test/test.data", memory);
  
  f = $fopen(`filename);
  $fmonitor(f, "time = %d\n", $time, 
  "\tmemory[0] = %b\n", memory[0],   
  "\tmemory[1] = %b\n", memory[1],
  "\tmemory[2] = %b\n", memory[2],
  "\tmemory[3] = %b\n", memory[3],
  "\tmemory[4] = %b\n", memory[4],
  "\tmemory[5] = %b\n", memory[5],
  "\tmemory[6] = %b\n", memory[6],
  "\tmemory[7] = %b\n", memory[7]);
  `simulation_time;
  $fclose(f);
 end
 
 always @(posedge clk) begin
  if (mem_write_en)
   memory[ram_addr] <= mem_write_data;
 end
 assign mem_read_data = (mem_read==1'b1) ? memory[ram_addr]: 32'd0; 

endmodule