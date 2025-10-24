import java.net.*;
import java.io.*;

public class Client {

    public static void main(String[] args) throws IOException {
        InetAddress addr = null;
        int port = -1;

        BufferedReader stdIn = new BufferedReader(new InputStreamReader(System.in));

        try {
            if (args.length == 2) {
                addr = InetAddress.getByName(args[0]);
                port = Integer.parseInt(args[1]);
                if (port < 1024 || port > 65535) {
                    System.out.println(
                            "Usage: java Client serverAddr serverPort");
                    System.exit(1);
                }
            } else {
                System.out.println("Usage: java Client serverAddr serverPort");
                System.exit(1);
            }
        } catch (Exception e) {
            System.out.println("Problemi, i seguenti: ");
            e.printStackTrace();
            System.out.println("Usage: java Client serverAddr serverPort");
            System.exit(2);
        }

        // Variables for sockets
        Socket socket = null;
        DataInputStream inSock = null;
        DataOutputStream outSock = null;

        try {
            socket = new Socket(addr, port);
            socket.setSoTimeout(30000);
            System.out.println("Creata la socket: " + socket);
            inSock = new DataInputStream(socket.getInputStream());
            outSock = new DataOutputStream(socket.getOutputStream());
        } catch (IOException ioe) {
            System.out.println("Problemi nella creazione degli stream su socket: ");
            ioe.printStackTrace();
            System.out.print("\n^D(Unix)/^Z(Win)+invio per uscire, solo invio per continuare: ");
            System.exit(1);
        }

        // variabili
        String servizio;

        // ciclo di invio richieste
        System.out.print("\n^D(Unix)/^Z(Win)+invio per uscire, altrimenti immetti il servizio:\nC) Conteggio linee\nT) Trasferimento file binari\n");
        while ((servizio = stdIn.readLine()) != null) {
            if (servizio.equals("C")) { // conteggio linee

            } else if (servizio.equals("T")) { // trasferimento file binari

            } else System.out.println("Servizio non valido\n");

            System.out.print("\n^D(Unix)/^Z(Win)+invio per uscire, altrimenti immetti il servizio:\nC) Conteggio linee\nT) Trasferimento file binari\n");
        }

        System.out.println("Client: termino...");
		socket.close();

    }
}