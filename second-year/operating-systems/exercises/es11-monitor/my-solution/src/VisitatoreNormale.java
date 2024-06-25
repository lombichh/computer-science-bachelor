import java.util.Random;

public class VisitatoreNormale extends Thread {
    SitoNaturalistico sitoNaturalistico;
    Random rand;

    public VisitatoreNormale(SitoNaturalistico sitoNaturalistico, Random rand) {
        this.sitoNaturalistico = sitoNaturalistico;
        this.rand = rand;
    }

    @Override
    public void run() {
        try {
            sitoNaturalistico.visitatoreNormaleEntraPonte();
            Thread.sleep(rand.nextInt(10 * 1000));
            sitoNaturalistico.visitatoreNormaleEntraIsola();
            Thread.sleep(rand.nextInt(10 * 1000));
            sitoNaturalistico.visitatoreNormaleEsceIsola();
            Thread.sleep(rand.nextInt(10 * 1000));
            sitoNaturalistico.visitatoreNormaleEscePonte();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
