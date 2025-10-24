/*
 * Nome: Matteo
 * Cognome: Lombardi
 * Matricola: 0001071217
 * Compito: 1
 */

// l'invio e la ricezione sono sincronizzati, come posso inviare più dati e consumare tutti gli input
// è possibile inviare una struttura (tipo lista) tramite stream socket

import java.io.*;
import java.net.*;

class ServerThread extends Thread {
    private Socket clientSocket = null;

    public ServerThread(Socket clientSocket) {
        this.clientSocket = clientSocket;
    }

    public void run() {
        System.out.println("Attivazione figlio: " + Thread.currentThread().getName());

        DataInputStream inSock;
        DataOutputStream outSock;

        try {
            inSock = new DataInputStream(clientSocket.getInputStream());
            outSock = new DataOutputStream(clientSocket.getOutputStream());
        } catch (IOException ioe) {
            System.out.println("Problemi nella creazione degli stream di input/output su socket: ");
            ioe.printStackTrace();
            return;
        }
        try {
            try {
                String matricola, nome, cognome;
                Integer input;
                int i, j, found, ris = 0;
                int numInputVoti, voto;
                int numMatricoleNonIscritte;
                String[] matricoleNonIscritte;

                System.out.println("In attesa del comando da eseguire...");
                while ((input = inSock.readInt()) != null) { // ricezione comando da eseguire

                    if (input == 1) { // iscrivere studente all'appello
                        // ricezione parametri
                        matricola = inSock.readUTF();
                        nome = inSock.readUTF();
                        cognome = inSock.readUTF();

                        System.out.println("Eseguo richiesta di iscrizione studente con matricola '" + matricola
                            + "', nome '" + nome + "' e cognome '" + cognome + "'");

                        // iscrizione studente
                        for (i = 0; i < Server.MAX_NUM_STUDENTI; i++) {
                            if (Server.studenti[i] == null) {
                                Studente newStudente = new Studente(matricola, nome, cognome, -1);
                                Server.studenti[i] = newStudente;
                            } else if (Server.studenti[i].matricola.compareTo(matricola) == 0) {
                                ris = -1;
                                break;
                            }
                        }

                        System.out.println("Iscrizione studente completata, invio risultato");

                        // invio risultato
                        outSock.writeInt(ris);
                    } else if (input == 2) { // caricare voti
                        // ricezione parametri
                        numInputVoti = inSock.readInt();

                        // inserimento voti
                        numMatricoleNonIscritte = 0;
                        matricoleNonIscritte = new String[Server.MAX_NUM_STUDENTI];
                        for (i = 0; i < numInputVoti; i++) {
                            matricola = inSock.readUTF();
                            voto = inSock.readInt();

                            found = 0;
                            for (j = 0; j < Server.MAX_NUM_STUDENTI; j++) {
                                if (Server.studenti[j].matricola.compareTo(matricola) == 0) {
                                    found = 1;
                                    Server.studenti[i].voto = voto;
                                }
                            }

                            if (found == 0) {
                                matricoleNonIscritte[numMatricoleNonIscritte] = matricola;
                                numMatricoleNonIscritte++;
                            }
                        }

                        System.out.println("Inserimento voti completato, invio risultato");

                        // invio matricole non iscritte
                        outSock.writeInt(numMatricoleNonIscritte);
                        for (i = 0; i < numMatricoleNonIscritte; i++) {
                            outSock.writeUTF(matricoleNonIscritte[i]);
                        }
                    }
                    System.out.println("In attesa del comando da eseguire...");
                }
            } catch (EOFException eof) {
                System.out.println("Raggiunta la fine delle ricezioni, chiudo...");
                clientSocket.close();
                System.out.println("ServerThread: termino...");
                System.exit(0);
            } catch (SocketTimeoutException ste) {
                System.out.println("Timeout scattato: ");
                ste.printStackTrace();
                clientSocket.close();
                System.exit(1);
            } catch (Exception e) {
                System.out.println("Problemi, i seguenti : ");
                e.printStackTrace();
                System.out.println("Chiudo ed esco...");
                clientSocket.close();
                System.exit(2);
            }
        } catch (IOException ioe) {
            System.out.println("Problemi nella chiusura della socket: ");
            ioe.printStackTrace();
            System.out.println("Chiudo ed esco...");
            System.exit(3);
        }
    }

}

public class Server {
    static final int MAX_NUM_STUDENTI = 50;
    static Studente[] studenti;

    public static void main(String[] args) throws IOException {
        int port = -1;

        // controllo argomenti
        try {
            if (args.length == 1) {
                port = Integer.parseInt(args[0]);
                // controllo che la porta sia nel range consentito 1024-65535
                if (port < 1024 || port > 65535) {
                    System.out.println("Usage: java Server [serverPort>1024]");
                    System.exit(1);
                }
            } else {
                System.out.println("Usage: java Server port");
                System.exit(1);
            }
        } catch (Exception e) {
            System.out.println("Problemi, i seguenti: ");
            e.printStackTrace();
            System.out.println("Usage: java Server port");
            System.exit(1);
        }

        // inizializza struttura dati
        studenti = new Studente[MAX_NUM_STUDENTI];

        // crea socket
        ServerSocket serverSocket = null;
        Socket clientSocket = null;

        try {
            serverSocket = new ServerSocket(port);
            serverSocket.setReuseAddress(true);
            System.out.println("Server: avviato ");
            System.out.println("Server: creata la server socket: " + serverSocket);
        } catch (Exception e) {
            System.err.println("Server: problemi nella creazione della server socket: " + e.getMessage());
            e.printStackTrace();
            serverSocket.close();
            System.exit(1);
        }

        // ciclo di ricezione richieste
        try {
            while (true) {
                System.out.println("Server: in attesa di richieste...\n");

                try {
                    clientSocket = serverSocket.accept();
                    System.out.println("Server: connessione accettata: " + clientSocket);
                } catch (Exception e) {
                    System.err.println("Server: problemi nella accettazione della connessione: " + e.getMessage());
                    e.printStackTrace();
                    continue;
                }

                try {
                    new ServerThread(clientSocket).start();
                } catch (Exception e) {
                    System.err.println("Server: problemi nel server thread: " + e.getMessage());
                    e.printStackTrace();
                    continue;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Server: termino...");
            System.exit(2);
        }
    }
}