`timescale 1ns / 1ps

module MorraCinese_tb();

  // File descriptors.
  	integer tbf, outf;
  
  // Inputs
  reg [1:0] PRIMO;
  reg [1:0] SECONDO;
  reg INIZIA;
  reg clk;

  // Outputs
  wire [1:0] MANCHE;
  wire [1:0] PARTITA;

  // Instantiate the MorraCinese module
  MorraCinese morracinese (
    PRIMO, SECONDO, INIZIA, clk, MANCHE, PARTITA
  );

  // Clock generation
  always #10 clk = ~clk;

  // Stimulus
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
    tbf = $fopen("testbench.script", "w");
    outf = $fopen("output_verilog.txt", "w");
    $fdisplay(tbf, "read_blif FSMD.blif");
    
    clk = 1'b0;
    
    //////// PARTITA 1 - 4 manche
    
    // Initialize inputs
    INIZIA = 1'b1;
    PRIMO = 2'b00;
    SECONDO = 2'b00;
    $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIA, PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0]);
    #30
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);

    // Wait for a few clock cycles
    
    // Start the game - Vincitore PAREGGIO
    INIZIA = 1'b0;
    
    PRIMO = 2'b01; SECONDO = 2'b10; // Player 2 wins
    $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIA, PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0]);
    #20 
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    PRIMO = 2'b01; SECONDO = 2'b11; // Player 1 wins
    $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIA, PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0]);
    #20 
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    PRIMO = 2'b10; SECONDO = 2'b10; // Draw
    $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIA, PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0]);
    #20 
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    PRIMO = 2'b11; SECONDO = 2'b11; // Draw
    $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIA, PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0]);
    #20 
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    
    
    //////// PARTITA 2 - 6 manche
    
    // Initialize inputs
    INIZIA = 1'b1;
    PRIMO = 2'b00;
    SECONDO = 2'b10;
    $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIA, PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0]);
    #40
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);

    
    // Start the game - Vincitore G2
    INIZIA = 1'b0;
    
    PRIMO = 2'b10; SECONDO = 2'b11; // Player 2 wins
	$fdisplay(tbf, "simulate %b %b %b %b %b", INIZIA, PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0]);
    #20 
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
        
    PRIMO = 2'b10; SECONDO = 2'b11; // Invalida: Stessa mossa G2
    $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIA, PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0]);
    #20 
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    PRIMO = 2'b10; SECONDO = 2'b00; // Invalida: mossa invalida G2
    $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIA, PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0]);
    #20 
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    PRIMO = 2'b00; SECONDO = 2'b10; // Invalida: mossa invalida G1
    $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIA, PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0]);
    #20 
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    PRIMO = 2'b10; SECONDO = 2'b11; // Invalida: Stessa mossa G2
    $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIA, PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0]);
    #20 
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    PRIMO = 2'b01; SECONDO = 2'b10; // Player 2 wins
    $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIA, PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0]);
    #20 
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    PRIMO = 2'b11; SECONDO = 2'b10; // Player 1 wins
    $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIA, PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0]);
    #20 
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    PRIMO = 2'b01; SECONDO = 2'b01; // Draw
    $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIA, PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0]);
    #20 
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    PRIMO = 2'b11; SECONDO = 2'b11; // Draw
    $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIA, PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0]);
    #20 
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    PRIMO = 2'b01; SECONDO = 2'b11; // Player 1 wins
    $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIA, PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0]);
    #20 
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    
    
    //////// PARTITA 3 - 6 manche
    
    // Initialize inputs
    INIZIA = 1'b1;
    PRIMO = 2'b00;
    SECONDO = 2'b10;
    $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIA, PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0]);
    #30
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);

    // Wait for a few clock cycles
    
    // Start the game - Vincitore G1 2 VITTORIE DI SCARTO 
    INIZIA = 1'b0;
    
    PRIMO = 2'b11; SECONDO = 2'b10; //Player 1 wins Game 1
    $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIA, PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0]);
    #20 
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1],MANCHE[0], PARTITA[1], PARTITA[0]);
    
    PRIMO = 2'b01; SECONDO = 2'b01; // Draw Game 2 
    $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIA, PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0]);
    #20 
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1],MANCHE[0], PARTITA[1], PARTITA[0]);
    PRIMO = 2'b01; SECONDO = 2'b10; // Player 2 wins Game 3 
    $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIA, PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0]);
    #20 
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1],MANCHE[0], PARTITA[1], PARTITA[0]);
    
    PRIMO = 2'b10; SECONDO = 2'b01; // Player 1 wins Game 4 
    $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIA, PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0]);
    #20 
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1],MANCHE[0], PARTITA[1], PARTITA[0]);
    
    PRIMO = 2'b10; SECONDO = 2'b11; // Player 1 invalidate Game 4 
    $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIA, PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0]);
    #20 
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1],MANCHE[0], PARTITA[1], PARTITA[0]);
    
    PRIMO = 2'b11; SECONDO = 2'b10; // Player 1 wins Game 5 
    $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIA, PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0]);
    #20 
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1],MANCHE[0], PARTITA[1], PARTITA[0]);
    
    
    
    $fdisplay(tbf, "quit");

	$fclose(tbf);
	$fclose(outf);
	$finish;


    #100 $stop;
  end

endmodule
