import java.util.Random;

public class Utente extends Thread {

	private Monitor m;
	private Random r;
	private int id;

	public Utente(Monitor m, int id, Random r) {

		this.id = id;
		this.m = m;
		this.r =r;

	}

	public void run() {
		int tipoServ=r.nextInt(2); // decisione del tipo di servizio
		int SP;
		try {
			Thread.sleep(1000 + r.nextInt(100));

			m.entraSala(id);

			Thread.sleep(1000 + r.nextInt(5000));

			SP=m.richiestaSportello(id, tipoServ);

			Thread.sleep(1000 + r.nextInt(5000));

			m.uscitaMotorizzazione(id, SP);

			Thread.sleep(1000 + r.nextInt(100));
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

}
