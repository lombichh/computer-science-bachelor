/*
 * Matricola: 0001071217
 * Nome: Matteo
 * Cognome: Lombardi
 * Compito: 2
 */

// controllare che il check int sia corretto

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
            System.out.println("Sintassi: Client registryHost [registryPort]");
            System.exit(1);
        } else {
            registryHost = args[0];
            if (args.length == 2) {
                try {
                    registryPort = Integer.parseInt(args[1]);
                } catch (Exception e) {
                    System.out
                        .println("Sintassi: Client registryHost [registryPort] (registryPort intero)");
                    System.exit(1);
                }
            }
        }

        // connessione al servizio RMI remoto
        try {
            String completeName = "//" + registryHost + ":" + registryPort + "/"
                    + serviceName;
            RMI_interfaceFile serverRMI = (RMI_interfaceFile) Naming.lookup(completeName);
            System.out.println("Client RMI: Servizio \"" + serviceName
                    + "\" connesso");

            System.out.println("\nRichieste di servizio fino a fine file");

            String service;
            System.out.print("Servizio (E=elimina occorrenze, L=lista file carattere): ");

            while ((service = stdIn.readLine()) != null) {
                if (service.equals("E")) { // elimina occorrenze
                    System.out.println("Richiesta eliminazione dei caratteri numerici da un file remoto");
                    
                    // input parametri
                    String nomeFile;
                    System.out.print("Nome file remoto: ");
                    nomeFile = stdIn.readLine();

                    // invocazione remota
                    try {
                        int numElim = serverRMI.eliminaOccorrenze(nomeFile);
                        
                        // stampa risultato
                        if (numElim == -1) System.out.println("Insuccesso nell'eliminazione remota");
                        else System.out.println("Sono state fatte " + numElim
                            + " eliminazioni di caratteri numerici dal file " + nomeFile);
                    } catch (RemoteException re) {
                        System.out.println("Errore remoto: " + re.toString());
                    }
                } else if (service.equals("L")) { // lista file carattere
                    System.out.println("Richiesta lista dei file remoti in un certo direttorio"
                        + " che contengono nel nome un numero minimo di occorrenze di un certo carattere");

                    // input parametri
                    String nomeDir, carStr;
                    char car;
                    int occ;

                    System.out.print("Nome direttorio remoto: ");
                    nomeDir = stdIn.readLine();

                    while (true) {
                        System.out.print("Carattere: ");
                        carStr = stdIn.readLine();
    
                        if (carStr.length() == 1) {
                            car = carStr.charAt(0);
                            break;
                        }
                    }

                    while (true) {
                        System.out.print("Numero minimo occorrenze: ");
                        try {
                            occ = Integer.parseInt(stdIn.readLine());
                            break;
                        } catch (NumberFormatException nfe) {
                            System.out.print("Errore: devi inserre un numero");
                        }
                    }

                    // invocazione remota
                    try {
                        String[] nomiFile = serverRMI.listaFileCarattere(nomeDir, car, occ);
                        
                        for (int i = 0; i < nomiFile.length; i++) {
                            System.out.println("Nome file: " + nomiFile[i]);
                        }
                    } catch (RemoteException re) {
                        System.out.println("Errore remoto: " + re.toString());
                    }
                } else System.out.println("Servizio non disponibile");

                System.out.print("Servizio (E=elimina occorrenze, L=lista file carattere): ");
            }
        } catch (Exception e) {
            System.err.println("Client RMI: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }
    }
}