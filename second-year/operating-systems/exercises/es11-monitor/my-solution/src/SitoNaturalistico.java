import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;

public class SitoNaturalistico {
    private int MAX;
    private int NP;

    // sync
    private ReentrantLock lock = new ReentrantLock();

    private Condition codaGuide[] = new Condition[2]; // 0 -> entraPonte; 1 -> esceIsola
    private Condition codaVisitatoriNormali[] = new Condition[2];
    private Condition codaVisitatoriZaino[] = new Condition[2];

    private int guideInAttesa[] = new int[2]; // 0 -> entraPonte; 1 -> esceIsola
    private int visitatoriNormaliInAttesa[] = new int[2];
    private int visitatoriZainoInAttesa[] = new int[2];

    private int guideInIsola;
    private int visitatoriZainoInPonte[] = new int[2]; // 0 -> direzione entrata; 1 -> direzione uscita
    private int totInPonte;
    private int totInIsola;

    public SitoNaturalistico(int MAX, int NP) {
        this.MAX = MAX;
        this.NP = NP;

        for (int i = 0; i < 2; i++) {
            codaGuide[i] = lock.newCondition();
            codaVisitatoriNormali[i] = lock.newCondition();
            codaVisitatoriZaino[i] = lock.newCondition();

            guideInAttesa[i] = 0;
            visitatoriNormaliInAttesa[i] = 0;
            visitatoriZainoInAttesa[i] = 0;

            visitatoriZainoInPonte[i] = 0;
        }

        this.guideInIsola = 0;
        this.totInPonte = 0;
        this.totInIsola = 0;
    }

    // guida
    public void guidaEntraPonte() throws InterruptedException {
        lock.lock();

        try {
            while (totInPonte == NP || totInIsola == MAX || visitatoriZainoInAttesa[1] > 0
                    || visitatoriNormaliInAttesa[1] > 0 || guideInAttesa[1] > 0) {
                guideInAttesa[0]++;
                codaGuide[0].await();
                guideInAttesa[0]--;
            }

            totInPonte++;
            totInIsola++;
        } finally {lock.unlock();}
    }

    public void guidaEscePonte() throws InterruptedException {
        lock.lock();

        try {
            totInPonte--;
            totInIsola--;

            if (visitatoriZainoInAttesa[1] > 0 && visitatoriZainoInPonte[0] == 0)
                codaVisitatoriZaino[1].signal();
            else if (visitatoriNormaliInAttesa[1] > 0)
                codaVisitatoriNormali[1].signal();
            else if (guideInAttesa[1] > 0 && guideInIsola > 1)
                codaGuide[1].signal();
            else if (guideInAttesa[0] > 0)
                codaGuide[0].signal();
            else if (visitatoriZainoInAttesa[0] > 0 && visitatoriZainoInPonte[1] == 0)
                codaVisitatoriZaino[0].signal();
            else if (visitatoriNormaliInAttesa[0] > 0)
                codaVisitatoriNormali[0].signal();
        } finally {lock.unlock();}
    }

    public void guidaEntraIsola() throws InterruptedException {
        lock.lock();

        try {

        } finally {lock.unlock();}
    }

    public void guidaEsceIsola() throws InterruptedException {
        lock.lock();

        try {

        } finally {lock.unlock();}
    }

    // visitatore normale
    public void visitatoreNormaleEntraPonte() throws InterruptedException {
        lock.lock();

        try {

        } finally {lock.unlock();}
    }

    public void visitatoreNormaleEscePonte() throws InterruptedException {
        lock.lock();

        try {

        } finally {lock.unlock();}
    }

    public void visitatoreNormaleEntraIsola() throws InterruptedException {
        lock.lock();

        try {

        } finally {lock.unlock();}
    }

    public void visitatoreNormaleEsceIsola() throws InterruptedException {
        lock.lock();

        try {

        } finally {lock.unlock();}
    }

    // visitatore con zaino
    public void visitatoreZainoEntraPonte() throws InterruptedException {
        lock.lock();

        try {

        } finally {lock.unlock();}
    }

    public void visitatoreZainoEscePonte() throws InterruptedException {
        lock.lock();

        try {

        } finally {lock.unlock();}
    }

    public void visitatoreZainoEntraIsola() throws InterruptedException {
        lock.lock();

        try {

        } finally {lock.unlock();}
    }

    public void visitatoreZainoEsceIsola() throws InterruptedException {
        lock.lock();

        try {

        } finally {lock.unlock();}
    }
}
