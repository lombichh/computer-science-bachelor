import java.util.Random;

public class Main {
    public static void main(String args[]) throws InterruptedException {
        Monitor m = new Monitor(5, 3);

        User users[] = new User[15];
        Random r = new Random(System.currentTimeMillis());
        for (int i = 0; i < 15; i++) {
            users[i] = new User(i, m, r.nextInt(2));
            users[i].start();
        }

        for (int i = 0; i < 15; i++) {
            users[i].join();
        }
        m.stampa();
    }
}
