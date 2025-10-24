import java.rmi.Remote;
import java.rmi.RemoteException;

public interface RMI_Server extends Remote {

    int eliminaSci(String id) throws RemoteException;

    int noleggiaSci(String id, String data, int giorni) throws RemoteException;
}