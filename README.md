# MorraCinese - Progetto di Architettura degli Elaboratori

## Descrizione

Questo progetto consiste nella realizzazione di una macchina digitale in grado di gestire partite di **Morra Cinese**, sviluppata come elaborato per il corso di Architettura degli Elaboratori.
Il circuito è composto da una **FSM** (controllore) e un **Datapath** (elaboratore) che comunicano tra loro.
Il progetto è stato sviluppato utilizzando **SIS** e **Verilog**.

## Autori

* Bortolaso Mattia (VR500026)
* Colombo Matteo (VR500130)

## Struttura del Repository

* `sis/`
  Contiene i file della FSM e del Datapath in formato `.blif`:

  * `fsm.blif`
  * `datapath.blif`
  * `FSMD.blif` (collegamento tra FSM e Datapath)

* `verilog/`
  Contiene la descrizione in Verilog della FSM e del Datapath:

  * `design.sv`

* `Relazione.pdf`
  Relazione dettagliata del progetto e delle scelte implementative.

## Architettura del Circuito

Il sistema implementa una FSM di tipo **Mealy** per la gestione degli stati del gioco:

* **SETUP:** Stato di reset; impostazione del numero di manche massime.
* **GAME:** Stato in cui si giocano le manche; possibilità di reset tramite segnale di inizio.
* **FINE:** Stato di attesa di una nuova partita.

### Datapath

Il Datapath gestisce:

* **Vincitore Manche:**
  Decreta il vincitore di ogni manche e applica i vincoli sulle mosse.
* **Vincitore Partita:**
  Determina il vincitore finale della partita considerando i round, il vantaggio e il rispetto dei vincoli sul numero minimo e massimo di manche.

Per maggiori dettagli tecnici si veda la relazione allegata.

## Statistiche del Circuito

* **Pre-ottimizzazione:**

  * Nodi: 168
  * Letterali: 833

* **Post-ottimizzazione:**

  * Nodi: 44
  * Letterali: 322

* **Mapping finale:**

  * Area totale: 4912
  * Gate Count: 129
  * Arrival Time (cammino critico): 51.80

## Scelte Progettuali

* Suddivisione tra FSM (controllore degli stati) e Datapath (elaborazione delle partite).
* Gestione del vantaggio tramite un registro a 4 bit.
* Gestione del contatore dei round tramite registro a 5 bit.
* Vincitore della manche calcolato tramite un componente logico dedicato.

## Come usare il progetto

1. Consulta la documentazione nella cartella `Relazione.pdf` per dettagli sull’architettura e sull’implementazione.
2. I file possono essere sintetizzati e simulati tramite gli strumenti SIS e Verilog.
3. Modifica e personalizza i file secondo le tue esigenze.

## Licenza

Questo progetto è a scopo didattico.
