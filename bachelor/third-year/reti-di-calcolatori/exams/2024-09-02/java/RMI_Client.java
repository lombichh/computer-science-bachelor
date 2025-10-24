/**
 * Nome: Matteo
 * Cognome: Lombardi
 * Matricola: 0001071217
 * Numero compito: 1
 */

import java.rmi.*;
import java.io.*;
 
class RMI_Client {

    public static void main(String[] args) {
        int registryPort = 1099;
        String registryHost = null;
        String serviceName = "Server";
        BufferedReader stdIn = new BufferedReader(new InputStreamReader(System.in));

        // controllo parametri
        if (args.length != 1 && args.length != 2) {
            System.out.println("Sintassi: ClientFile [registryHost] [registryPort]");
            System.exit(1);
        } else {
            registryHost = args[0];
            if (args.length == 2) {
                try {
                    registryPort = Integer.parseInt(args[1]);
                } catch (Exception e) {
                    System.out.println("Sintassi: ClientFile [registryHost] [registryPort], registryPort intero");
                    System.exit(1);
                }
            }
        }

        // connessione al servizio RMI remoto
        try {
            String completeName = "//" + registryHost + ":" + registryPort + "/" + serviceName;
            RMI_Server serverRMI = (RMI_Server) Naming.lookup(completeName);
            System.out.println("Client RMI: Servizio \"" + serviceName + "\" connesso");

            System.out.println("\nRichieste di servizio fino a fine file");

            String service;
            String dirName, fileName, word;
            String[] listaFile;
            int num;
            System.out.print("Servizio (L = Lista file, E = Elimina righe): ");

            while ((service = stdIn.readLine()) != null) {
                if (service.equals("L")) {
                    // servizio lista file
                    System.out.print("Nome direttorio: ");
                    dirName = stdIn.readLine();

                    // invocazione remota
                    try {
                        listaFile = serverRMI.lista_filetesto(dirName);
                        // TODO: controllare errori
                        System.out.println("Lista file nel direttorio \"" + dirName + "\": ");
                        for (int i = 0; i < listaFile.length; i++) {
                            System.out.println(listaFile[i]);
                        }
                    } catch (RemoteException re) {
                        System.out.println("Errore remoto: " + re.toString());
                    }
                } else if (service.equals("E")) {
                    // servizio elimina righe
                    System.out.print("Nome file: ");
                    fileName = stdIn.readLine();

                    System.out.print("Parola da eliminare: ");
                    word = stdIn.readLine();

                    try {
                        num = serverRMI.elimina_linee_contenenti_parola(fileName, word);
                        System.out.println("Sono state eliminare " + num + " linee contenenti la parola \""
                            + word + "\" all'interno del file " + fileName);
                    } catch (RemoteException re) {
                        System.out.println("Errore remoto: " + re.toString());
                    }
                } else System.out.println("Servizio non disponibile");

                System.out.print("Servizio (L = Lista file, E = Elimina righe): ");
            }
        } catch (Exception e) {
            System.err.println("ClientRMI: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }
    }

}