import java.util.concurrent.locks.*;
// Esercitazione 11.1: per fare terminare il programma, prevedo che una guida possa uscire 
// dalla tomba quando la tomba è vuota

public class Monitor {
	private final int NP=10;
	private final int MAX=15;
	public  final int IN = 0;
	public  final int OUT = 1;

	//variabili di stato per isola
	private int totIsola;
	private int guideInIsola;

	//variabili di stato per il ponte
	private int totPonte;
	private int[] normali = new int[2];
	private int[] zaini  = new int[2];
	private int[] guide   = new int[2];

	private Lock l = new ReentrantLock();
	private Condition[] codaNormali = new Condition[2];
	private Condition[] codaZaini = new Condition[2];
	private Condition[] codaGuide = new Condition[2];

	private int[] sospN= new int[2];
	private int[] sospZ= new int[2];
	private int[] sospG= new int[2];

	public Monitor() {
		totIsola=0;
		guideInIsola=0;
		totPonte=0;
		normali[IN]=0;
		normali[OUT]=0;
		zaini[IN]=0;
		zaini[OUT]=0;
		guide[IN]=0;
		guide[OUT]=0;

		sospN[IN]=0;
		sospN[OUT]=0;
		sospZ[IN]=0;
		sospZ[OUT]=0;
		sospG[IN]=0;
		sospG[OUT]=0;

		codaNormali[IN] = l.newCondition(); 
		codaNormali[OUT] = l.newCondition();
		codaZaini[IN] = l.newCondition();
		codaZaini[OUT] = l.newCondition();
		codaGuide[IN] = l.newCondition();
		codaGuide[OUT] = l.newCondition();		

	}
	public void entraNormale (int id, int dir) throws InterruptedException
	{
		l.lock();
		try {
			if (dir==IN) {
				while (totPonte==NP || totIsola==MAX || guideInIsola==0 || sospZ[OUT]>0 || sospN[OUT]>0 || sospG[OUT]>0 || sospG[IN]>0 || sospZ[IN]>0) {
					sospN[IN]++;
					codaNormali[IN].await();
					sospN[IN]--;
				}
				totPonte++;
				normali[IN]++;
				totIsola++;
				System.out.println("Normale "+id+" entrato nel ponte dir=IN.\n"+stato());
			}else { // direzione OUT
				while (totPonte==NP || sospZ[OUT]>0 ) {
					sospN[OUT]++;
					codaNormali[OUT].await();
					sospN[OUT]--;
				}
				totPonte++;
				normali[OUT]++;
				totIsola--;
				System.out.println("Normale "+id+" entrato nel ponte dir=OUT.\n"+stato());
				//MANCAVANO SIGNAL A NORMALI, ZAINI e GUIDE in direzione IN (sospesi x capacità isola):
				if (sospZ[OUT]+sospN[OUT]+sospG[OUT]==0) // se non c'è nessuno in attesa di uscire
				{	if (sospG[IN]>0)
						codaGuide[IN].signal();
					else if (sospZ[IN]>0 ) 
						codaZaini[IN].signal();	
					else if (sospN[IN]>0 )
						codaNormali[IN].signal();
				}
			}
			
		} catch (InterruptedException e) {} 
		finally {l.unlock();}

	}

	public void esciNormale(int id, int dir) 
	{
		l.lock();
		try{
		if (dir==IN) {
			totPonte--;
			normali[IN]--;	
			System.out.println("Normale "+id+" uscito dal ponte dir=IN.\n"+stato());
		}else { //OUT
			totPonte--;
			normali[OUT]--;
			System.out.println("Normale "+id+" uscito dal ponte dir=OUT.\n"+stato());
		}

		// Signal al più prioritario in attesa:

		if(sospZ[OUT]>0 ) 
			codaZaini[OUT].signal();
		else if (sospN[OUT]>0)
			codaNormali[OUT].signal();
		else if (sospG[OUT]>0 )
			codaGuide[OUT].signal();
		else if (sospG[IN]>0 )
			codaGuide[IN].signal();
		else if (sospZ[IN]>0 ) 
			codaZaini[IN].signal();	
		else if (sospN[IN]>0 )
			codaNormali[IN].signal();
		}finally {l.unlock();}
	}

	public void entraZaino(int id, int dir) throws InterruptedException
	{
		l.lock();
		try {
			if (dir==IN) {
				while (totPonte+2>NP || totIsola+2>MAX || guideInIsola==0 || zaini[OUT]>0 || sospZ[OUT]>0 || sospN[OUT]>0 || sospG[OUT]>0 || sospG[IN]>0) {
					sospZ[IN]++;
					codaZaini[IN].await();
					sospZ[IN]--;
				}
				totPonte+=2;
				zaini[IN]++;
				totIsola+=2;
				System.out.println("Zaino "+id+" entrata nel ponte dir=IN.\n"+stato());
			}else { //OUT
				while (totPonte+2>NP || zaini[IN]>0) { //massima priorità
					sospZ[OUT]++;
					codaZaini[OUT].await();
					sospZ[OUT]--;
				}
				totPonte+=2;
				zaini[OUT]++;
				totIsola-=2;
				System.out.println("Zaino "+id+" entrata nel ponte dir=OUT.\n"+ stato());	
				//MANCAVANO SIGNAL A NORMALI e GUIDE in direzione IN (sospesi x capacità grotta):
				if (sospZ[OUT]+sospN[OUT]+sospG[OUT]==0) // se non c'è nessuno in attesa di uscire
				{	if (sospG[IN]>0)
					{	codaGuide[IN].signal();	
				 		codaGuide[IN].signal();	
					}
					else if (sospN[IN]>0 )
					{	codaNormali[IN].signal();
						codaNormali[IN].signal();
					}
				}			
			}
		} catch (InterruptedException e) {} 
		finally {l.unlock();}
	}

	public void esciZaino(int id, int dir) 
	{	l.lock();
	try{
	if (dir==IN) {
		totPonte-=2;
		zaini[IN]--;	
		System.out.println("Zaino "+id+" uscita dal ponte dir=IN.\n"+stato());
	}else //OUT
	{
		totPonte-=2;
		zaini[OUT]--;	
		System.out.println("Zaino "+id+" uscita dal ponte dir=OUT.\n"+stato());
	}


	if(sospZ[OUT]>0 && zaini[IN]==0) 
		codaZaini[OUT].signalAll();
	if (sospN[OUT]>0)
	{	codaNormali[OUT].signal();
		codaNormali[OUT].signal();
	}
	if (sospG[OUT]>0 )
	{	codaGuide[OUT].signal();
		codaGuide[OUT].signal();
	}
	if (sospG[IN]>0 ) {
		codaGuide[IN].signal();
		codaGuide[IN].signal();
	}
	if (sospZ[IN]>0 && zaini[OUT]==0) 
		codaZaini[IN].signalAll();	
	if (sospN[IN]>0 ) {
		codaNormali[IN].signal();
		codaNormali[IN].signal();
	}
	}finally {l.unlock();}
	}

	public void entraGuida(int id, int dir) throws InterruptedException
	{	l.lock();
	try {
		if (dir==IN) {
			while (totPonte==NP || totIsola==MAX || sospZ[OUT]>0 || sospN[OUT]>0 || sospG[OUT]>0) {
				sospG[IN]++;
				codaGuide[IN].await();
				sospG[IN]--;
			}
			totPonte++;
			guide[IN]++;
			totIsola++;
			guideInIsola++;
			System.out.println("Guida "+id+" entrata nel ponte dir=IN.\n"+stato());
		}else { //OUT
			while (totPonte==NP || (guideInIsola==1 && totIsola-guideInIsola>0)|| sospZ[OUT]>0 || sospN[OUT]>0 ) {
				// spiegazione di && totIsola-guideInIsola>0 : 
				// per fare terminare il programma, prevedo che una guida possa uscire dall'isola quando l'isola è vuota
				sospG[OUT]++;
				codaGuide[OUT].await();
				sospG[OUT]--;
			}
			totPonte++;
			guide[OUT]++;
			totIsola--;
			guideInIsola--;
			System.out.println("Guida "+id+" entrata nel ponte dir=OUT.\n"+stato());			
			//MANCAVANO SIGNAL A NORMALI, ZAINI e GUIDE in direzione IN (sospesi x capacità grotta)
			if (sospZ[OUT]+sospN[OUT]+sospG[OUT]==0) // se non c'è nessuno in attesa di uscire
			{	if (sospG[IN]>0)
					codaGuide[IN].signal();
				else if (sospZ[IN]>0 ) 
					codaZaini[IN].signal();	
				else if (sospN[IN]>0 )
					codaNormali[IN].signal();
			}	
		}
	} catch (InterruptedException e) {} 
	finally {l.unlock();}
	}

	public void esciGuida(int id, int dir) 
	{	l.lock();
	try{
	if (dir==IN) {
		totPonte--;
		guide[IN]--;	
		System.out.println("Guida "+id+" uscita dal ponte dir=IN.\n"+stato());
	}else { //OUT
		totPonte--;
		guide[OUT]--;
		System.out.println("Guida "+id+" uscita dal ponte dir=OUT.\n"+stato());
	}

	// Signal al più prioritario in attesa:

	if(sospZ[OUT]>0 ) 
		codaZaini[OUT].signal();
	else if (sospN[OUT]>0)
		codaNormali[OUT].signal();
	else if (sospG[OUT]>0 )
		codaGuide[OUT].signal();
	else if (sospG[IN]>0 )
		codaGuide[IN].signal();
	else if (sospZ[IN]>0 ) 
		codaZaini[IN].signal();	
	else if (sospN[IN]>0 )
		codaNormali[IN].signal();
	}finally {l.unlock();}
	}


	public String stato() { //per DEBUG
		return "[totIsola="+totIsola+" guideInIsola="+guideInIsola+" totPonte="+totPonte
				+ " normaliIN="+normali[IN]+" zainiIN="+zaini[IN]+" guideIN="+guide[IN]
						+ " normaliOUT="+normali[OUT]+" zainiOUT="+zaini[OUT]+" guideOUT="+guide[OUT]
								+ " sospNin="+sospN[IN]+" sospZin="+sospZ[IN]+" sospGin="+sospG[IN]
										+ " sospNout="+sospN[OUT]+" sospZout="+sospZ[OUT]+" sospGout="+sospG[OUT]+"   ]";
	}


}