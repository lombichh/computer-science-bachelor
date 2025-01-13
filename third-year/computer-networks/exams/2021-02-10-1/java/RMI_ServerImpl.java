import java.io.File;
import java.rmi.Naming;
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

public class RMI_ServerImpl extends UnicastRemoteObject implements RMI_Server {
    private final static int MAX_NUM_NOLEGGI = 30;
    private static Noleggio noleggi[];

    public RMI_ServerImpl() throws RemoteException {
        super();
    }

    public int eliminaSci(String id) throws RemoteException {
        int eliminato = -1;
        int i = 0;
        File fileFoto;

        while (eliminato == -1 && i < MAX_NUM_NOLEGGI) {
            if (noleggi[i].id.equals(id)) {
                // eliminazione sci
                noleggi[i].id = "L";
                noleggi[i].data = "L";
                noleggi[i].giorni = -1;
                noleggi[i].modello = "L";
                noleggi[i].costoGiornaliero = -1;

                fileFoto = new File(noleggi[i].nomeFileFoto);
                if (fileFoto.delete()) System.out.println("Eliminazione foto " + noleggi[i].nomeFileFoto  + " andata a buon fine");
                else System.out.println("Eliminazione foto " + noleggi[i].nomeFileFoto  + " non andata a buon fine");

                noleggi[i].nomeFileFoto = "L";

                System.out.println("Sci con identificatore " + id  + " eliminato");

                eliminato = 1;
            }
            i++;
        }

        return eliminato;
    }

    public int noleggiaSci(String id, String data, int giorni) throws RemoteException {
        int trovato = 0;
        int i = 0;
        int esito = -1;

        while (trovato == 0 && i < MAX_NUM_NOLEGGI) {
            if (noleggi[i].id.equals(id)) {
                trovato = 1;
                if (noleggi[i].giorni <= 0) {
                    noleggi[i].data = data;
                    noleggi[i].giorni = giorni;
                    esito = 1;
                }
            }
            i++;
        }

        return esito;
    }

    // Avvio del Server RMI
	public static void main(String[] args) {
        noleggi = new Noleggio[MAX_NUM_NOLEGGI];

        // inizializza noleggi
        for (int i = 0; i < MAX_NUM_NOLEGGI; i++) {
            noleggi[i] = new Noleggio("L", "L", -1, "L", -1, "L");
        }
        
		final int REGISTRYPORT = 1099;
		String registryHost = "localhost";
		String serviceName = "ServerNoleggio"; // lookup name...

		// Registrazione del servizio RMI
		String completeName = "//" + registryHost + ":" + REGISTRYPORT + "/" + serviceName;
		try {
			RMI_ServerImpl serverRMI = new RMI_ServerImpl();
			Naming.rebind(completeName, serverRMI);
			System.out.println("Server RMI: Servizio \"" + serviceName + "\" registrato");
		} catch (Exception e) {
			System.err.println("Server RMI \"" + serviceName + "\": " + e.getMessage());
			e.printStackTrace();
			System.exit(1);
		}
	}
}