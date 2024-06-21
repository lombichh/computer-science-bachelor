
import java.util.concurrent.locks.*;  // stazione=0 --> A, stazione=1 --> B, stazione=2 --> C

public class Monitor {
	
	Lock lock= new ReentrantLock();
	// stazioni:
	
	final int A=0;
	final int B=1;
	final int C=2;
	// op:
	final int prel=0; // prelievo
	final int rest=1; //restituzione
	int max; // capacità massima stazione
	Condition[][] singoli=new Condition [3][2];// matrice 3x2 indici: stazione, operazione
	Condition[][] coppie= new Condition [3][2];
	int[][] s_sosp=new int[3][2];
	int[][] c_sosp=new int[3][2];
	
	int[] cassa=new int[3]; // una cassa per ogni stazione
	int[] tot=new int[3]; //num bici presenti in ogni stazione
	
	public Monitor(int capstaz, int initstaz) {
		int i, j;
		max=capstaz;
		
		for (i=0; i<3; i++)
		{	cassa[i]=100; // la cassa è vuota
			tot[i]=initstaz; // num. bici in ogni stazione
			for(j=0; j<2; j++)
			{	
				singoli[i][j]=lock.newCondition();
				coppie[i][j]=lock.newCondition();
				s_sosp[i][j]=0;
				c_sosp[i][j]=0;
			}
		}
	}
	
	public void noleggio1bici (String ID, int staz) throws InterruptedException
	{
		lock.lock();
		try
		{
			
				while (tot[staz]==0)
				{
					s_sosp[staz][prel]++;
					singoli[staz][prel].await();
					s_sosp[staz][prel]--;
				}
				tot[staz]--;
				System.out.println ("Il cliente singolo "+ID+" ha prelevato una bici dalla stazione " + staz);
				cassa[staz]+=10;
				System.out.println ("La stazione "+staz+" contiene "+tot[staz]+" bici e la cassa ammonta a "+cassa[staz]);
				if (c_sosp[staz][rest]!=0)
					coppie[staz][rest].signal();
				else if (s_sosp[staz][rest]!=0)
					singoli[staz][rest].signal();

		} finally {lock.unlock();}
	}
	
	public void consegna1bici (String ID, int staz) throws InterruptedException
	{
		lock.lock();
		try
		{
			
				while ((cassa[staz]<10) || (c_sosp[staz][rest]>0) || (tot[staz]==max))
				{
					s_sosp[staz][rest]++;
					singoli[staz][rest].await();
					s_sosp[staz][rest]--;
				}
				tot[staz]++;
				cassa[staz]-=10;
				System.out.println ("Il cliente singolo "+ID+" ha restituito una bici alla stazione "+staz);
				System.out.println ("La stazione "+staz+" contiene "+tot[staz]+" bici e la cassa ammonta a "+cassa[staz]);
				if (s_sosp[staz][prel]>0)
					singoli[staz][prel].signal();
				else if (c_sosp[staz][prel]>0)
					coppie[staz][prel].signal();
		} finally {lock.unlock();}
	}
	
	public void noleggio2bici (String ID, int staz) throws InterruptedException
	{
		lock.lock();
		try
		{
			while ((tot[staz]<2) || (s_sosp[staz][prel]!=0))
				{
					c_sosp[staz][prel]++;
					coppie[staz][prel].await();
					c_sosp[staz][prel]--;
				}
			tot[staz]-=2;
			cassa[staz]+=20;
			System.out.println ("La coppia "+ID+" ha noleggiato due bici nella stazione "+staz);
				System.out.println ("La stazione "+staz+" contiene "+tot[staz]+" bici e la cassa ammonta a "+cassa[staz]);
				if (c_sosp[staz][rest]>0)
				coppie[staz][rest].signal();
			else if (s_sosp[staz][rest]>0 && cassa[staz]>=20)
			{ 	singoli[staz][rest].signal();
				singoli[staz][rest].signal();}
			if (s_sosp[staz][rest]>0 && cassa[staz]==10)
				 singoli[staz][rest].signal();

	
		} finally {lock.unlock();}
	}
	
	public void consegna2bici (String ID, int staz) throws InterruptedException
	{
		lock.lock();
		try
		{
				while ((cassa[staz]<20) || (tot[staz]+2 >max))
				{
					c_sosp[staz][rest]++;
					coppie[staz][rest].await();
					c_sosp[staz][rest]--;
				}
				
				tot[staz]+=2;
				cassa[staz]-=20;
				System.out.println ("\nIl cliente coppia "+ID+" ha restituito due bici alla stazione "+staz);
				System.out.println ("La stazione "+staz+" contiene "+tot[staz]+" bici e la cassa ammonta a "+cassa[staz]);
				if (s_sosp[staz][prel]>0)
				{	singoli[staz][prel].signal();
					singoli[staz][prel].signal();
				}
				else if (c_sosp[staz][prel]>0)
					coppie[staz][prel].signal();
				
				
		} finally {lock.unlock();}
	}

}
