
import java.util.Random;


public class Singolo extends Thread{

	Monitor M;
	
	public Singolo(Monitor M) {
		this.M=M;
	}
	
	public void run ()
	{
		
		int time, stazione;
		Random r= new Random();
		time=(r.nextInt(5)+1)*1000;
		try
		{
				stazione=r.nextInt(3);
				M.noleggio1bici(this.getName(), stazione);
				sleep (time);
				stazione=r.nextInt(3);
				M.consegna1bici(this.getName(), stazione);
				sleep(1000);
		} catch (InterruptedException e) {}
	}

}
