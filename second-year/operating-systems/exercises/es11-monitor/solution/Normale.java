import java.util.Random;

public class Normale extends Thread {

	private Random r;
	private Monitor m;
	private int Id;


	public Normale(Random r,Monitor m, int id) {
		
		this.r = r;
		this.m = m;
		this.Id=id;
	}


	public void run() {
		try {
			Thread.sleep(100*r.nextInt(5));
			m.entraNormale(Id, m.IN);
			Thread.sleep(100*r.nextInt(5));
			m.esciNormale(Id, m.IN);
			Thread.sleep(100*r.nextInt(5));
			m.entraNormale(Id, m.OUT);
			Thread.sleep(100*r.nextInt(5));
			m.esciNormale(Id, m.OUT);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
