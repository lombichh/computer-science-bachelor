
/**
 *  Interfaccia remota Registry per il Cliente.
 *  	Cerca = ottiene il primo riferimento al server registrato con 'nomeLogico'.
 *  	CercaTutti = ottiene tutti i riferimenti ai server registrati con 'nomeLogico'.
 */

import java.rmi.Remote;
import java.rmi.RemoteException;

public interface RegistryRemotoClient extends Remote {
	Remote cerca(String nomeLogico) throws RemoteException;

	Remote[] cercaTutti(String nomeLogico) throws RemoteException;
}
