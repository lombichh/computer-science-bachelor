/*
 * Matricola: 0001071217
 * Nome: Matteo
 * Cognome: Lombardi
 * Compito: 2
 */

import java.rmi.Remote;
import java.rmi.RemoteException;

public interface RMI_interfaceFile extends Remote {
	/**
	 * @param nomeFile = nome del file remoto
	 * @throws RemoteException = FileNotFound, IOException
     * @return: int numero occorrenze (-1 in caso di insuccesso)
	 **/
	public int eliminaOccorrenze(String nomeFile) throws RemoteException;

	/**
	 * @param nomeDir = nome del direttorio remoto
	 * @param car = carattere da ricercare nel nome del file
	 * @param occ = numero di occorrenze minimo del carattere
	 * @throws RemoteException = = FileNotFound, IOException
	 * @return: lista dei file con nel nome un numero minimo occ di occorrenze di car
	 **/
	public String[] listaFileCarattere(String nomeDir, char car, int occ) throws RemoteException;
}