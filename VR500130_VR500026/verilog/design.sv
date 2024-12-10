module MorraCinese(
  input [1:0] PRIMO,
  input [1:0] SECONDO,
  input INIZIA, // Segnale di reset
  input clk, // Segnale di clock 
  output reg [1:0] MANCHE,
  output reg [1:0] PARTITA
);
  
parameter nomove = 2'b00;
parameter sasso = 2'b01;
parameter carta = 2'b10;
parameter forbice = 2'b11;
  
parameter invalid = 2'b00;
parameter G1win = 2'b01;
parameter G2win = 2'b10;
parameter draw = 2'b11; //pareggio
  
  
   // Altri registri nel datapath
  
  reg [3:0] vantaggio = 4'b0000;
  reg [1:0] lastMovePlayer1 = 2'b00; // Ultima mossa del giocatore 1
  reg [1:0] lastMovePlayer2 = 2'b00; // Ultima mossa del giocatore 2
  reg [4:0] roundCount = 5'b00000; // Contatore delle manche giocate
  reg [4:0] maxRound = 5'b00000; // Numero massimo di manche
  reg inizio = 1'b0, fine = 1'b0; //segnale di stato e controllo

  // Dichiarazioni degli stati
  reg [2:0] state = 3'b000;
  reg [2:0] nextState = 3'b000;
  
  always @(clk) begin : UPDATE
        state = nextState;      
    end
  
   // FSM
  always @(INIZIA, fine, state) begin : FSM
    case(state)
      2'b00: // Stato di setup
        if(INIZIA) begin
          inizio = 1'b1;
        end
        else begin
          inizio = 1'b0;
          nextState = 2'b01; //prossimo stato: partita
        end

      2'b01: // Stato partita
        if(fine) begin
          nextState = 2'b10; //prossimo stato: fine partita
        end else
        if(INIZIA) begin
          nextState = 2'b00; //prossimo stato: setup
        end

      2'b10: // Fine partita
        if(INIZIA) begin
          nextState = 2'b00; //prossimo stato: setup
        end
    endcase
  end

  
  //DATAPATH
  always @(posedge clk) begin : DATAPATH
    if(inizio) begin //reset
      vantaggio = 3'b100;
      lastMovePlayer1 = 2'b00;
      lastMovePlayer2 = 2'b00;
      roundCount = 5'b00000;
      PARTITA = 2'b00;
      MANCHE = 2'b00;
      fine = 1'b0;
      
      maxRound = {PRIMO, SECONDO} + 3'b100; //concatenazione segnali PRIMO e SECONDO + 4
      
    end else if(!fine) begin
      
      //----------------MOSSE INVALIDE------------------------
      if(PRIMO == nomove || SECONDO == nomove) begin //controllo mosse invalide
        MANCHE = invalid;
      end 
        
      //----------------PAREGGIO------------------------------
       else if(PRIMO == SECONDO) begin //controllo se mosse giocate sono uguali
          
         if(PRIMO == lastMovePlayer1 || SECONDO == lastMovePlayer2) begin //controlla ultime mosse giocatori
            MANCHE = invalid;
          end
          else begin
            MANCHE = draw; //manche pareggiata
            
            lastMovePlayer1 = nomove;
            lastMovePlayer2 = nomove;
            roundCount++;

          end
        end else
          
          //----------------VINCE ROUND G1------------------------------
          if((PRIMO == sasso && SECONDO == forbice ) || (PRIMO == carta && SECONDO == sasso) || (PRIMO == forbice && SECONDO == carta)) begin //vince giocatore 1
            if(PRIMO == lastMovePlayer1) begin //controlla ultima mossa
              MANCHE = invalid;
            end
            else begin
              MANCHE = G1win;
              
              lastMovePlayer1 = PRIMO;
              lastMovePlayer2 = nomove;
              
              vantaggio--;
              
              roundCount++;
            end
          end else

            //----------------VINCE ROUND G2------------------------------
            if((SECONDO == sasso && PRIMO == forbice ) || (SECONDO == carta && PRIMO == sasso) || (SECONDO == forbice && PRIMO == carta)) begin //vince giocatore 2
              if(SECONDO == lastMovePlayer2) begin //controlla ultima mossa
                MANCHE = invalid;
              end
              else begin
                MANCHE = G2win;
                
                lastMovePlayer2 = SECONDO;
                lastMovePlayer1 = nomove;
                
                vantaggio++;
                
                roundCount++;
              end
            end
      
           //----------------VINCITORE PARTITA------------------------------

      if(roundCount > 3) begin //controlla se sono state giocate le partite minime per vincere
        if(vantaggio > 5) begin //giocatore 1 è in vantaggio di almeno 2 manche
          PARTITA = G2win;
          fine = 1'b1;
        end
        else if(vantaggio < 3) begin //giocatore 2 è in vantaggio di almeno 2 manche
          PARTITA = G1win;
          fine = 1'b1;
        end
        else begin
          PARTITA = invalid; //nessuno è in vantaggio di 2
        end
      end
      
      if(roundCount == maxRound) begin //numero di manche massimo raggiunto, partita finita in pareggio
        PARTITA = (vantaggio > 4) ? G2win : (vantaggio < 4) ? G1win : draw; //Se ha vinto più manche G1 vince G1, se ha vinto più manche G2 vince G2, altrimenti la partita è finita in pareggio
        fine = 1'b1;
      end
       
      
    end
    
  end  

endmodule
  