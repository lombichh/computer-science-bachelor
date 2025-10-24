/*
 * Matricola: 0001071217
 * Nome: Matteo
 * Cognome: Lombardi
 * Compito: 2
 */

import java.io.*;
import java.net.*;

class ServerThread extends Thread {
    private Socket clientSocket = null;
    private int bufferSize = 4096;

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

        String inputStr;
        char tipoOp;

        String idSeriale, cartaId;
        int i, found, ris;

        String imgFolder;
        byte[] buffer = new byte[bufferSize];
        int byteInviati, byteLetti;
        long byteTotali;
        DataInputStream inFotoFile = null;
        File dirFoto, fotoFile;
        File[] fotoFiles;
        String ok;
        
        try {
            try {
                System.out.println("Attendo il comando dal client...");
                while (true) {
                    tipoOp = inSock.readChar();

                    if (tipoOp == 'A') { // aggiornamento carta di identita
                        // ricezione parametri
                        idSeriale = inSock.readUTF();
                        cartaId = inSock.readUTF();

                        System.out.println("Richiesta aggiornamento monopattino " + idSeriale 
                            + " con carta di identita " + cartaId);

                        // aggiornamento carta
                        ris = 0;
                        found = 0;
                        for (i = 0; i < Server.MAX_PRENOTAZIONI; i++) {
                            if (Server.prenotazioni[i].idSeriale.compareTo(idSeriale) == 0) {
                                found = 1;
                                if (Server.prenotazioni[i].cartaId.compareTo("L") == 0) {
                                    Server.prenotazioni[i].cartaId = cartaId;
                                } else ris = -1;
                                break;
                            }
                        }
                        if (found == 0) ris = -1;

                        System.out.println("Carta di identita aggiornata, invio risultato\n");

                        // invio risultato
                        outSock.writeInt(ris);
                    } else if (tipoOp == 'D') { // download foto monopattino
                        // ricezione parametro
                        idSeriale = inSock.readUTF();

                        System.out.println("Richiesta download foto con id" + idSeriale);

                        // invio foto
                        found = 0;
                        imgFolder = "";
                        for (i = 0; i < Server.MAX_PRENOTAZIONI; i++) {
                            if (Server.prenotazioni[i].idSeriale.compareTo(idSeriale) == 0) {
                                imgFolder = Server.prenotazioni[i].imgFolder;
                                found = 1;
                                break;
                            }
                        }

                        if (imgFolder.equals("")) outSock.writeInt(0);
                        else {
                            dirFoto = new File(imgFolder);
                            if (dirFoto.exists() && dirFoto.isDirectory()) {
                                fotoFiles = dirFoto.listFiles();
                                outSock.writeInt(fotoFiles.length); // invio numero file foto
                                for (i = 0; i < fotoFiles.length; i++) {
                                    fotoFile = fotoFiles[i];
                                    if (fotoFile.isFile()) {
                                        System.out.println("File con nome: " + fotoFile.getName());
                                        
                                        outSock.writeUTF(fotoFile.getName()); // invio nome file foto

                                        ok = inSock.readUTF(); // ricezione salta o invia

                                        if (ok.equals("invia")) {
                                            System.out.println("La foto " + fotoFile.getName()
                                                    + " non e' presente sul client: inizio il trasferimento");
                                            byteTotali = fotoFile.length();
                                            outSock.writeLong(byteTotali); // invio byte totali
                                            
                                            inFotoFile = new DataInputStream(new FileInputStream(fotoFile.getAbsolutePath()));
                                            try {
                                                byteInviati = 0;
                                                while (byteInviati < byteTotali) {
                                                    byteLetti = inFotoFile.read(buffer);
                                                    outSock.write(buffer, 0, byteLetti);
                                                    byteInviati += byteLetti;
                                                }
                                                outSock.flush();
                                                System.out.println("Foto " + fotoFile.getName() + " inviata");
                                            } catch (EOFException e) {
                                                System.out.println("Problemi, i seguenti: ");
                                                e.printStackTrace();
                                            }
                                        } else if (ok.equals("salta"))
                                            System.out.println("La foto " + fotoFile.getName()
                                                + " era gia' presente sul client e non e' stato sovrascritto");
                                        else {
                                            System.out.println("ServerThread: violazione protocollo, file saltato");
                                            System.exit(4);
                                        }
                                    }
                                }
                            }
                        }
                    }

                    System.out.println("Attendo il comando dal client...");
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
    public static int MAX_PRENOTAZIONI = 20;
    public static Prenotazione[] prenotazioni;

    public static void main(String[] args) throws IOException {
        int port = -1;

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

        ServerSocket serverSocket = null;
        Socket clientSocket = null;

        try {
            serverSocket = new ServerSocket(port);
            serverSocket.setReuseAddress(true);
            System.out.println("Server: creata la server socket: " + serverSocket);
        } catch (Exception e) {
            System.err.println("Server: problemi nella creazione della server socket: " + e.getMessage());
            e.printStackTrace();
            serverSocket.close();
            System.exit(1);
        }

        // inizializzazione struttura
        prenotazioni = new Prenotazione[MAX_PRENOTAZIONI];
        for (int i = 0; i < MAX_PRENOTAZIONI; i++) {
            prenotazioni[i] = new Prenotazione("L", "L", "L", "L");
        }

        prenotazioni[0].idSeriale = "1";
        prenotazioni[0].imgFolder = "1_img/";

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