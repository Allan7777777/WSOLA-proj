      WSOLA_PROJECT - waveform similarity overlap add
		            Simone Persico 224368

- wsola_project -> file MATLAB da mandare in run;

- l'algoritmo prende un file audio in input e lo allunga/accorcia
  in relazione al parametro TSR. (TSR=2 => velocità 2x)

- nelle prime righe i diversi file di input e le relative info 
  sono commentati, si deve decommentare quello che si vuole utilizzare;
	
- nella parte di setup troviamo i vari parametri L, S, TSR, delta.
  Possiamo modificarli entro certi limiti e mandare in run per
  sentire il risultato.

- dopo aver sistemato il primo frame, l'algoritmo viene implementato 
  all'interno del ciclo while:
  isolo i due frame da confrontare e ne faccio la crosscorrelazione.
  il risultato è un vettore, estraggo l'indice indicante correlazione massima
  e quindi isolo il frame corrispondente copiandolo in output,
  dopo aver aggiornato gli indici reitero il procedimento;

- esecuzione dell'output;

- stampa dei grafici: in rosso l'input e in blu l'output.
