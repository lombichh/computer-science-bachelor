import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class Monitor {
    private static int MAX;
    private static int NS;

    private int erogati[] = new int[2];

    private Lock lock = new ReentrantLock();
    private Condition sala = lock.newCondition();
    private Condition sportelloDoc = lock.newCondition();
    private Condition sportelloRes = lock.newCondition();
    private int postiDisponibiliSala;
    private int sportelliDisponibili;
    private int sospSala;
    private int sospDoc;
    private int sospRes;

    public Monitor(int MAX, int NS) {
        this.MAX = MAX;
        this.NS = NS;

        this.postiDisponibiliSala = MAX;
        this.sportelliDisponibili = NS;
        this.sospSala = 0;
        this.sospDoc = 0;
        this.sospRes = 0;
    }

    public void entraSala(int id, int servizio) throws InterruptedException {
        lock.lock();
        try {
            while (postiDisponibiliSala == 0) {
                sospSala++;
                sala.await();
                sospSala--;
            }

            postiDisponibiliSala--;
            System.out.println(id + " entrato in sala: " + servizio);
        } finally {lock.unlock();}
    }

    public void richiediServizio(int id, int servizio) throws InterruptedException {
        lock.lock();
        try {
            if (servizio == 0) {
                while (sportelliDisponibili == 0) {
                    sospDoc++;
                    sportelloDoc.await();
                    sospDoc--;
                }
            } else {
                while (sportelliDisponibili == 0 | sospDoc > 0) {
                    sospRes++;
                    sportelloRes.await();
                    sospRes--;
                }
            }

            sportelliDisponibili--;
            System.out.println(id + " allo sportello: " + servizio);
            erogati[servizio]++;

            postiDisponibiliSala++;
            if (sospSala > 0) sala.signal();
        } finally {lock.unlock();}
    }

    public void esci(int id) {
        lock.lock();
        try {
            sportelliDisponibili++;
            System.out.println(id + " uscito");

            if (sospDoc > 0) sportelloDoc.signal();
            else sportelloRes.signal();
        } finally {lock.unlock();}
    }

    public void stampa() {
        System.out.println("La motorizzazione ha erogato " + erogati[0] + " documenti di identità e "
                + "effettuato " + erogati[1] + " cambi di residenza");
    }
}
