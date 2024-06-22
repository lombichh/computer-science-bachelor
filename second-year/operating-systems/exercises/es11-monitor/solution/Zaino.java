import java.util.Random;

public class Zaino extends Thread {

	private Random r;
	private Monitor m;
	private int Id;


	public Zaino(Random r,Monitor m, int id) {

		this.r = r;
		this.m = m;
		this.Id=id;
	}



	public void run() {
		try {
			Thread.sleep(100*r.nextInt(5));
			m.entraZaino(Id, m.IN);
			Thread.sleep(100*r.nextInt(5));
			m.esciZaino(Id, m.IN);
			Thread.sleep(100*r.nextInt(5));
			m.entraZaino(Id, m.OUT);
			Thread.sleep(100*r.nextInt(5));
			m.esciZaino(Id, m.OUT);
		} catch (InterruptedException e) {}
	}
}
