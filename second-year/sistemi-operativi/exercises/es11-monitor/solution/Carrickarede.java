import java.util.Random;

public class Carrickarede {

	public static void main(String[] args) {
		final int MAXTHREAD=10;
		Random r = new Random();
		Monitor m = new Monitor();
		int nNormali=r.nextInt(MAXTHREAD)+1; // numero thread normali
		Normale[] normali = new Normale[nNormali];
		int nZai=r.nextInt(MAXTHREAD)+1; //numero thread zaino
		Zaino[] zai = new Zaino[nZai];
		int nGuide=r.nextInt(MAXTHREAD)+1;
		Guida[] guide = new Guida[nGuide];
		System.out.println("Benvenuti al Carrickarede!\n Ci sono "+nNormali+" Visitatori normali;\n"+nZai+" Visitatori con zaino;\n"+nGuide+" Guide.\n\n");
		for (int i = 0; i < nNormali; i++) {
			normali[i]=new Normale(r, m,i);
		}
		for (int i = 0; i < nZai; i++) {
			zai[i]=new Zaino(r, m,i);
		}		
		for (int i = 0; i < nGuide; i++) {
			guide[i]=new Guida(r, m,i);
		}
		for (int i = 0; i < nNormali; i++) {
			normali[i].start();
		}
		for (int i = 0; i < nZai; i++) {
			zai[i].start();
		}		
		for (int i = 0; i < nGuide; i++) {
			guide[i].start();
		}
	}
}
