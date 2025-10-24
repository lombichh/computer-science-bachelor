import java.util.Random;
import java.util.concurrent.locks.*;


public class Monitor {

	private final int DOC=0;
	private final int CAM=1;
	private int MAX; //numero posti a sedere in sala d'aspetto
	private int NS; //numero sportelli
	private int SportelliLiberi;
	private int PostiLiberi;
	private boolean [] LiberoSP; 
	private int TotU=0;
	private int [] Erogati=new int[2];
	//sincronizzazione:
	private Lock l = new ReentrantLock();
	private Condition codaSala = l.newCondition();
	private int sospSala=0;
	private Condition codaSportello = l.newCondition();
	private int sospSportello=0;

	public Monitor(int max, int ns) {

		this.MAX = max;
		PostiLiberi=MAX;
		this.NS=ns;
		SportelliLiberi=NS;
		LiberoSP= new boolean[NS];

		for (int i=0;i<NS; i++)
			LiberoSP[i]=true;

		Erogati[DOC]=0;
		Erogati[CAM]=0;

	}

	public void entraSala(int id) {
		l.lock();
		try {
			while (PostiLiberi==0) { // se non c'è posto attende...
				sospSala++;
				System.out.println("Utente " + id +": in attesa...");
				codaSala.await();
				sospSala--;
			}
			PostiLiberi--;

			System.out.println("Utente " + id +": sono entrato in sala d'aspetto!");

		} catch (InterruptedException e) {} 
		finally {l.unlock(); }
		return;
	}

	public int richiestaSportello(int id, int tipoServ) {
		int ris=-1;
		l.lock();
		try {
			while (SportelliLiberi==0) { // se non c'è uno sportello libero, attende...
				sospSportello++;
				System.out.println("Utente " + id +": in attesa di sportello per il servizio "+tipoServ);
				codaSportello.await();
				sospSportello--;
			}
			// individuazione sportello da assegnare
			for (int i=0; i<NS; i++)
				if (LiberoSP[i]==true)
				{	LiberoSP[i]=false;
				ris=i;
				break;
				}
			SportelliLiberi--;
			PostiLiberi++;
			Erogati[tipoServ]++;
			TotU++;

			System.out.println("Utente " + id +": mi è stato assegnato lo sportello "+ris+"!");

			// ho liberato un posto in sala di attesa: risveglio il primo processo in coda
			if (sospSala>0)
				codaSala.signal();			

		} catch (InterruptedException e) {} 
		finally {l.unlock(); }
		return ris;

	}

	public void uscitaMotorizzazione(int id, int sp) {
		l.lock();

		SportelliLiberi++;
		LiberoSP[sp]=true;

		System.out.println("Utente: " + id +": sono uscito liberando lo sportello "+sp);
		if (sospSportello>0)
			codaSportello.signal();

		l.unlock();


	}

	public void Stampa() {
		l.lock();

		System.out.println("Situazione finale:\n Sono stati serviti " + TotU +" utenti; ");
		System.out.println("Servizi erogati: \n Documenti="+Erogati[DOC]+"; \t Cambi="+Erogati[CAM] + ".");
		if (sospSportello>0)
			codaSportello.signal();

		l.unlock();

	}
}