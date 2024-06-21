
import java.util.Random;

public class URP {


		private final static int MAX=50; // capacità (numero massimo di persone in sala)
		private final static int NS=10; // numero sportelli


		public static void main(String args[]) {
			final int U_MAX = 200; // numero massimo di thread 
			
			Random r = new Random(System.currentTimeMillis());
			int NT=r.nextInt(U_MAX); // numero effettivo utenti 
	
			System.out.println("\n Esercitazione 10.2\nApertura del URP - la capacità è "+MAX+"; ci sono: " + NS +" sportelli e " + NT+ " Utenti\n\n");
			Monitor M = new Monitor(MAX, NS);
			Utente[] utenti = new Utente[NT];
		
			for(int i=0;i<NT;i++)
				utenti[i]=new Utente(M, i, r);
			
			for(int i=0;i<NT;i++)
				utenti[i].start();
			
			try {
				 
				 for(int i=0; i<NT; i++)
					 utenti[i].join();
			 } catch (InterruptedException e) {	}
			
			M.Stampa();
		}
	}
