import java.util.Random;

public class User extends Thread {
    private int id;
    private Monitor monitor;
    private int servizio;

    public User(int id, Monitor monitor, int servizio) {
        this.id = id;
        this.monitor = monitor;
        this.servizio = servizio;
    }

    @Override
    public void run() {
        try {
            monitor.entraSala(id, servizio);
            Thread.sleep(10000);
            monitor.richiediServizio(id, servizio);
            Thread.sleep(10000);
            monitor.esci(id);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
