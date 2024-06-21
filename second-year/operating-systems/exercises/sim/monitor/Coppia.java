
import java.util.Random;


public class Coppia extends Thread{

	Monitor M;
	
	public Coppia(Monitor M) {
		this.M=M;
	}
	
	public void run ()
	{
		
		int time, stazione;
		Random r= new Random();
		time=(r.nextInt(5)+1)*1000;
		try
		{ 		stazione=r.nextInt(3);
				M.noleggio2bici(this.getName(), stazione);
				sleep (time);
				stazione=r.nextInt(3);
				M.consegna2bici(this.getName(), stazione);
				sleep (1000);
		} catch (InterruptedException e) {}
	}

}