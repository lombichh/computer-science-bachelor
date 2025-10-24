import java.util.Random;

public class Guida extends Thread {
    SitoNaturalistico sitoNaturalistico;
    Random rand;

    public Guida(SitoNaturalistico sitoNaturalistico, Random rand) {
        this.sitoNaturalistico = sitoNaturalistico;
        this.rand = rand;
    }

    @Override
    public void run() {
        try {
            while (true) {
                sitoNaturalistico.guidaEntraPonte();
                Thread.sleep(rand.nextInt(10 * 1000));
                sitoNaturalistico.guidaEntraIsola();
                Thread.sleep(rand.nextInt(10 * 1000));
                sitoNaturalistico.guidaEsceIsola();
                Thread.sleep(rand.nextInt(10 * 1000));
                sitoNaturalistico.guidaEscePonte();
                Thread.sleep(rand.nextInt(20 * 1000));
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
