/*
 * Matricola: 0001071217
 * Nome: Matteo
 * Cognome: Lombardi
 * Compito: 2
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

        // variabili per socket
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

        // ciclo di invio richieste al server
        String inputStr;
        char tipoOp;

        String idSeriale, cartaId;
        int ris;

        int bufferSize = 4096;
        byte[] buffer = new byte[bufferSize];
        long byteTotali, byteRicevuti;
        int numFoto, i, byteLetti;
        String nomeFotoFile;
        File fotoFile;
        DataOutputStream outFotoFile = null;

        System.out.print("\n^D(Unix)/^Z(Win)+invio per uscire, altrimenti immetti il comando che vuoi eseguire:\n"
            + "- A: aggiornamento della carta di identita\n- D: Download foto di un monopattino\n");
        while ((inputStr = stdIn.readLine()) != null) {
            if (inputStr.length() != 1 && inputStr.charAt(0) != 'A' && inputStr.charAt(0) != 'D') {
                System.out.println("Devi inserire un carattere (A o D)");
                System.out.print("\n^D(Unix)/^Z(Win)+invio per uscire, altrimenti immetti il comando che vuoi eseguire:\n"
                    + "- A: aggiornamento della carta di identita\n- D: Download foto di un monopattino\n");
                continue;
            }

            tipoOp = inputStr.charAt(0);

            // invio tipo operazione al server
            outSock.writeChar(tipoOp);

            if (tipoOp == 'A') { // aggiornamento carta di identita
                System.out.println("--- Aggiornamento carta di identita ---");
                // invio parametri richiesta
                System.out.println("Id seriale del monopattino: ");
                idSeriale = stdIn.readLine();
                outSock.writeUTF(idSeriale);

                System.out.println("Numero della carta di identita: ");
                do {
                    cartaId = stdIn.readLine();
                    if (cartaId.length() <= 5) break;
                    System.out.println("Numero della carta di identita (max 5 interi): ");
                } while (true);
                outSock.writeUTF(cartaId);

                System.out.println("Richiesta di aggiornamento della carta di identita inviata"
                    + " con id seriale '" + idSeriale + "', e numero id card '" + cartaId + "'");

                // ricezione risultato
                System.out.println("Attesa risultato...");

                ris = inSock.readInt();
                if (ris == 0) System.out.println("Aggiornamento della carta di identita avvenuto con successo");
                else if (ris == -1) System.out.println("Problemi nell'aggiornamento della carta di identita");
            } else if (tipoOp == 'D') { // download foto monopattino
                System.out.println("--- Download foto monopattino ---");
                // invio parametri richiesta
                System.out.println("Id seriale del monopattino: ");
                idSeriale = stdIn.readLine();
                outSock.writeUTF(idSeriale);

                // ricezione foto
                numFoto = inSock.readInt(); // ricezione numero foto
                System.out.println("Numero foto da ricevere: " + numFoto);

                for (i = 0; i < numFoto; i++) {
                    nomeFotoFile = inSock.readUTF(); // ricezione nome foto
                    fotoFile = new File(nomeFotoFile);

                    if (fotoFile.exists()) {
                        outSock.writeUTF("salta");
                        continue;
                    }
                    outSock.writeUTF("invia"); // invio ris

                    byteTotali = inSock.readLong(); // ricezione byte totali
                    System.out.println("Scarico la foto " + nomeFotoFile + " di " + byteTotali + " byte");

                    // download foto
                    outFotoFile = new DataOutputStream(new FileOutputStream(nomeFotoFile));
                    byteRicevuti = 0;
                    try {
                        while (byteRicevuti < byteTotali) {
                            byteLetti = inSock.read(buffer); // ricezione buffer
                            outFotoFile.write(buffer, 0, byteLetti);
                            byteRicevuti += byteLetti;
                        }
                        outFotoFile.flush();
                        System.out.println("Foto " + nomeFotoFile + " scaricata");
                    } catch (EOFException e) {
                        System.out.println("Problemi, i seguenti: ");
                        e.printStackTrace();
                    }

                    outFotoFile.close();
                }
                System.out.println("Fine download foto");
            }

            System.out.print("\n^D(Unix)/^Z(Win)+invio per uscire, altrimenti immetti il comando che vuoi eseguire:\n"
            + "- A: aggiornamento della carta di identita\n-Download foto di un monopattino\n");
        }

        System.out.println("Client: termino...");
        socket.close();
    }
} 