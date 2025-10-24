import java.util.Random;

public class bici{
final static int Nmax=30;

	public static void main(String[] args) {
		int N=30;
		int caps, initstaz;
		int nums, numc;
		Random r= new Random ();
		
		caps=15; // capacità singola stazione
		initstaz=10;
		System.out.println ("Ci sono "+N+" BICI IN TOTALE; LA CAPACITà DI OGNI STAZIONE è "+caps+"; per ogni stazione ci sono "+initstaz+" bici");
		Monitor M=new Monitor(caps, initstaz);
		
		
		int i;
		nums=r.nextInt(50);
		numc=r.nextInt(30);
		System.out.println ("Ci sono "+nums+" clienti singoli e "+numc+" coppie");
		Singolo []s=new Singolo [nums];
		Coppia []c=new Coppia [numc];
		for (i=0; i<nums; i++)
			s[i]=new Singolo(M);
		for (i=0; i<numc; i++)
			c[i]=new Coppia(M);
		for (i=0; i<nums; i++)
			s[i].start();
		for (i=0; i<numc; i++)
			c[i].start();

	}

}
