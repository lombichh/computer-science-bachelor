import java.util.Random;

public class VisitatoreZaino extends Thread {
    SitoNaturalistico sitoNaturalistico;
    Random rand;

    public VisitatoreZaino(SitoNaturalistico sitoNaturalistico, Random rand) {
        this.sitoNaturalistico = sitoNaturalistico;
        this.rand = rand;
    }

    @Override
    public void run() {
        try {
            sitoNaturalistico.visitatoreZainoEntraPonte();
            Thread.sleep(rand.nextInt(10 * 1000));
            sitoNaturalistico.visitatoreZainoEntraIsola();
            Thread.sleep(rand.nextInt(10 * 1000));
            sitoNaturalistico.visitatoreZainoEsceIsola();
            Thread.sleep(rand.nextInt(10 * 1000));
            sitoNaturalistico.visitatoreZainoEscePonte();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
