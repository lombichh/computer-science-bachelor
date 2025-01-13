/*
 * Matricola: 0001071217
 * Nome: Matteo
 * Cognome: Lombardi
 * Compito: 2
 */

import java.io.*;
import java.rmi.Naming;
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

public class RMI_Server extends UnicastRemoteObject implements RMI_interfaceFile {

    public RMI_Server() throws RemoteException {
        super();
    }

    public int eliminaOccorrenze(String nomeFile) throws RemoteException {
		String nomeFileOut;
		File inFile, outFile;
		FileReader inFileReader;
		FileWriter outFileWriter;
        int car, numElim;

		try {
			inFileReader = new FileReader(nomeFile);

            nomeFileOut = nomeFile.substring(0, (nomeFile.length() - 4)) + "_modified.txt";
			outFile = new File(nomeFileOut);
			outFileWriter = new FileWriter(outFile);
		} catch (FileNotFoundException e) {
			throw new RemoteException(e.toString());
		} catch (IOException e) {
			throw new RemoteException(e.toString());
		}

		try {
			numElim = 0;
			while ((car = inFileReader.read()) != -1) {
                if (car < '0' || car > '9') outFileWriter.write(car);
                else numElim++;
			}
			inFileReader.close();
			outFileWriter.close();

			// rimpiazza il file originale con quello temporaneo
			inFile = new File(nomeFile);
			inFile.delete();
			outFile.renameTo(inFile);
		} catch (IOException e) {
			throw new RemoteException(e.toString());
		}

        return numElim;
    }

    public String[] listaFileCarattere(String nomeDir, char car, int occ) throws RemoteException {
        File dir, file;
        File[] files;

        int i, j, index, currOcc, numFile;
        String[] nomiFile;

        dir = new File(nomeDir);
        if (dir.exists() && dir.isDirectory()) {
            files = dir.listFiles();

            // conteggio numero file
            numFile = 0;
            for (i = 0; i < files.length; i++) {
                file = files[i];
                if (file.isFile() && file.getName().substring(
                        file.getName().length() - 4, 
                        file.getName().length()).equals(".txt")) {
                    currOcc = 0;
                    for (j = 0; j < file.getName().substring(0, file.getName().length() - 4).length(); j++) {
                        if (file.getName().charAt(j) == car) {
                            currOcc++;
                            if (currOcc > occ) {
                                numFile++;
                                break;
                            }
                        }
                    }
                }
            }

            // creazione lista
            nomiFile = new String[numFile];
            index = 0;
            for (i = 0; i < files.length; i++) {
                file = files[i];
                if (file.isFile() && file.getName().substring(
                    file.getName().length() - 4, 
                    file.getName().length()).equals(".txt")) {
                    currOcc = 0;
                    for (j = 0; j < file.getName().substring(0, file.getName().length() - 4).length(); j++) {
                        if (file.getName().charAt(j) == car) {
                            currOcc++;
                            if (currOcc > occ) {
                                nomiFile[index] = file.getName();
                                index++;
                                break;
                            }
                        }
                    }
                }
            }

            return nomiFile;
        } else throw new RemoteException("La cartella remota " + nomeDir + " non esiste");
    }

    public static void main(String[] args) {
        int registryPort = 1099;
        String registryHost = "localhost";
        String serviceName = "Server";

        // Controllo parametri
        if (args.length != 0 && args.length != 1) {
            System.out.println("Sintassi: Server [registryPort]");
            System.exit(1);
        }
        if (args.length == 1) {
            try {
                registryPort = Integer.parseInt(args[0]);
            } catch (Exception e) {
                System.out.println("Sintassi: Server [registryPort] (registryPort intero)");
                System.exit(2);
            }
        }

        // registrazione del servizio RMI
        String completeName = "//" + registryHost + ":" + registryPort + "/" + serviceName;
        try {
            RMI_Server serverRMI = new RMI_Server();
            Naming.rebind(completeName, serverRMI);
            System.out.println("Server RMI: Servizio \"" + serviceName + "\" registrato");
        } catch (Exception e) {
            System.err.println("Server RMI \"" + serviceName + "\": " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }
    }
}