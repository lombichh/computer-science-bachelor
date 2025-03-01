
/**
 *  Interfaccia remota Registry per il Server. Estende quella per il Client.
 *  	Aggiungi = aggiunge un server remoto, dato 'nomeLogico', 'Riferimento'.
 *  	RestituisciTutti = tutte le coppie [nomelogico][riferimento] registrate.
 *  	EliminaPrimo/Tutti = elimina prima/tutte entry corrispondente al 'nomeLogico'.
 */

import java.rmi.Remote;
import java.rmi.RemoteException;

public interface RegistryRemotoServer extends RegistryRemotoClient {
	boolean aggiungi(String nomeLogico, Remote riferimento) throws RemoteException;

	Object[][] restituisciTutti() throws RemoteException;

	boolean eliminaPrimo(String nomeLogico) throws RemoteException;

	boolean eliminaTutti(String nomeLogico) throws RemoteException;
}
