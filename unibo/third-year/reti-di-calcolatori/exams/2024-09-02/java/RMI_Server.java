/**
 * Nome: Matteo
 * Cognome: Lombardi
 * Matricola: 0001071217
 * Numero compito: 1
 */

import java.rmi.Remote;
import java.rmi.RemoteException;

public interface RMI_Server extends Remote {
    public String[] lista_filetesto(String dirName) throws RemoteException;

    public int elimina_linee_contenenti_parola(String fileName, String word) throws RemoteException;
}