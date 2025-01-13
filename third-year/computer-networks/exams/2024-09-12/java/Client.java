/*
 * Nome: Matteo
 * Cognome: Lombardi
 * Matricola: 0001071217
 * Compito: 1
 */

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

        // variabili per la socket
        Socket socket = null;
        DataInputStream inSock = null;
        DataOutputStream outSock = null;

        try {
            socket = new Socket(addr, port);
            System.out.println("Creata la socket: " + socket);
            inSock = new DataInputStream(socket.getInputStream());
            outSock = new DataOutputStream(socket.getOutputStream());
        } catch (IOException ioe) {
            System.out.println("Problemi nella creazione degli stream su socket: ");
            ioe.printStackTrace();
            System.out.print("\n^D(Unix)/^Z(Win)+invio per uscire, solo invio per continuare: ");
            System.exit(1);
        }

        // ciclo di invio di richieste al server
        String inputLine;
        int input;

        String matricola, nome, cognome;
        int ris;

        int numInputVoti, numMatricoleNonIscritte;

        System.out.println("Inserire:\n1\tIscrivere studente all'appello\n2\tCaricare voti\n^D\tper terminare: ");
        while ((inputLine = stdIn.readLine()) != null) {
            try {
                input = Integer.parseInt(inputLine);
            } catch (NumberFormatException e) {
                System.out.println("Errore: devi inserire un numero");
                System.out.println("Inserire:\n1\tIscrivere studente all'appello\n2\tCaricare voti\n^D\tper terminare: ");
                continue;
            }

            if (input == 1) { // iscrivere studente all'appello
                outSock.writeInt(input); // invio comando da eseguire

                // invio parametri
                System.out.println("Inserisci matricola: ");
                matricola = stdIn.readLine();
                outSock.writeUTF(matricola);

                System.out.println("Inserisci nome: ");
                nome = stdIn.readLine();
                outSock.writeUTF(nome);

                System.out.println("Inserisci cognome: ");
                cognome = stdIn.readLine();
                outSock.writeUTF(cognome);

                System.out.println("Inviata richiesta di iscrizione studente con matricola '" + matricola
                    + "', nome '" + nome + "' e cognome '" + cognome + "'");

                // ricezione risultato
                System.out.println("Attendo risultato...");
                ris = inSock.readInt();

                if (ris == 0) System.out.println("Iscrizione avvenuta con successo\n");
                else System.out.println("Errore: impossibile effettuare l'iscrizione\n");
            } else if (input == 2) { // caricare voti
                outSock.writeInt(input); // invio comando da eseguire

                // invio parametri
                try {
                    System.out.println("Inserisci il numero di voti da inserire: ");
                    numInputVoti = Integer.parseInt(stdIn.readLine());
                    outSock.writeInt(numInputVoti);

                    for (int i = 0; i < numInputVoti; i++) {
                        System.out.println("Matricola " + i + ": ");
                        outSock.writeUTF(stdIn.readLine());

                        System.out.println("Voto " + i + ": ");
                        outSock.writeInt(Integer.parseInt(stdIn.readLine()));
                    }

                    // ricezione risultato
                    System.out.println("Attendo risultato...");
                    numMatricoleNonIscritte = inSock.readInt();

                    if (numMatricoleNonIscritte == 0) System.out.println("Tutti i voti sono stati inseriti");
                    else {
                        for (int i = 0; i < numMatricoleNonIscritte; i++) {
                            System.out.println("La matricola " + inSock.readUTF() + " non è iscritta");
                        }
                    }
                } catch (NumberFormatException e) {
                    System.out.println("Errore: devi inserire un numero");
                    System.out.print("Inserire:\n1\tIscrivere studente all'appello\n2\tCaricare voti\n^D\tper terminare: ");
                    continue;
                }
            } else {
                System.out.println("Errore: il numero inserito non corrisponde ad un comando");
            }

            System.out.println("Inserire:\n1\tIscrivere studente all'appello\n2\tCaricare voti\n^D\tper terminare: ");
        }

        System.out.println("Client: termino...");
        socket.close();
    }
} 