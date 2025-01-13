/**
 * Nome: Matteo
 * Cognome: Lombardi
 * Matricola: 0001071217
 * Numero compito: 1
 */

import java.io.*;
import java.rmi.Naming;
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

public class RMI_Server_Impl extends UnicastRemoteObject implements RMI_Server {
 
    // Costruttore
    public RMI_Server_Impl() throws RemoteException {
        super();
    }

    public String[] lista_filetesto(String dirName) throws RemoteException {
        File dir = new File(dirName);

        if (dir.exists() && dir.isDirectory()) {
            String[] listaFiletesto;
            File[] files;
            File file;
            String fileName;
            int i, numFiletesto, index;

            files = dir.listFiles();

            // conta filetesto
            numFiletesto = 0;
            for (i = 0; i < files.length; i++) {
                file = files[i];
                fileName = file.getName();
                if (file.isFile() && fileName.substring(fileName.length() - 4, fileName.length()).compareTo(".txt") == 0) {
                    numFiletesto++;
                }
            }

            // crea lista filetesto
            listaFiletesto = new String[numFiletesto];
            index = 0;
            for (i = 0; i < files.length; i++) {
                file = files[i];
                fileName = file.getName();
                if (file.isFile() && fileName.substring(fileName.length() - 4, fileName.length()).compareTo(".txt") == 0) {
                    listaFiletesto[index] = fileName;
                    index++;
                }
            }

            return listaFiletesto;
        } else throw new RemoteException("Nome directory non valido");
    }

    public int elimina_linee_contenenti_parola(String fileName, String word) throws RemoteException {
        String outFileName;
        File fileIn, fileOut;
        BufferedReader fileInReader;
        FileWriter fileOutWriter;
        String line;
        int deletedRowsCounter;

        try {
            fileIn = new File(fileName);
            fileInReader = new BufferedReader(new FileReader(fileIn));

            outFileName = fileName.substring(0, (fileName.length() - 4)) + "_modified.txt";
            fileOut = new File(outFileName);
            fileOutWriter = new FileWriter(fileOut);
        } catch (FileNotFoundException e) {
            throw new RemoteException(e.toString());
        } catch (IOException e) {
            throw new RemoteException(e.toString());
        }

        try {
            deletedRowsCounter = 0;
            while ((line = fileInReader.readLine()) != null) {
                if (line.indexOf(" " + word + " ") >= 0 
                    || line.indexOf(" " + word) == (line.length() - word.length() - 1)
                    || line.indexOf(word + " ") == 0) deletedRowsCounter++;
                else fileOutWriter.write(line + "\n");
            
            }
            fileInReader.close();
            fileOutWriter.close();

            // replace the original file with the tmp
            fileIn.delete();
            fileOut.renameTo(fileIn);
        } catch (IOException e) {
            throw new RemoteException(e.toString());
        }

        return deletedRowsCounter;
    }

    public static void main(String[] args) {
        int registryPort = 1099;
        String registryHost = "localhost";
        String serviceName = "Server";

        // controllo parametri
        if (args.length != 0 && args.length != 1) {
            System.out.println("Sintassi: RMI_Server_Impl [registryPort]");
            System.exit(1);
        }
        if (args.length == 1) {
            try {
                registryPort = Integer.parseInt(args[0]);
            } catch (Exception e) {
                System.out.println("Sintassi: RMI_Server_Impl [registryPort], registryPort intero");
                System.exit(2);
            }
        }

        // registrazione del servizio RMI
        String completeName = "//" + registryHost + ":" + registryPort + "/" + serviceName;
        try {
            RMI_Server_Impl serverRMI = new RMI_Server_Impl();
            Naming.rebind(completeName, serverRMI);
            System.out.println("Server RMI: Servizio \"" + serviceName + "\" registrato");
        } catch (Exception e) {
            System.err.println("Server RMI \"" + serviceName + "\": " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }
    }
    
}