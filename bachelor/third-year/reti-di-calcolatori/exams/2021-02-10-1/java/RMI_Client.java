import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.rmi.Naming;
import java.rmi.NotBoundException;

class RMI_Client {
    public static void main(String[] args) {
        final int REGISTRYPORT = 1099;
        String registryHost = null; // host remoto con registry
        String serviceName = "";
        BufferedReader stdIn = new BufferedReader(new InputStreamReader(System.in));

        // Controllo dei parametri della riga di comando
        if (args.length != 2) {
            System.out.println("Sintassi: RMI_Registry_IP ServiceName");
            System.exit(1);
        }
        registryHost = args[0];
        serviceName = args[1];

        System.out.println("Invio richieste a " + registryHost + " per il servizio di nome " + serviceName);

        // Connessione al servizio RMI remoto
        try {
            String completeName = "//" + registryHost + ":" + REGISTRYPORT + "/" + serviceName;
            RMI_Server serverRMI = (RMI_Server) Naming.lookup(completeName);
            System.out.println("ClientRMI: Servizio \"" + serviceName + "\" connesso");

            System.out.println("\nRichieste di servizio fino a fine file");

            String service;
            System.out.print("Servizio (E=Eliminazione, N:Noleggio): ");

            /* ciclo accettazione richieste utente */
            while ((service = stdIn.readLine()) != null) {
                if (service.equals("E")) {
                    System.out.println("-- Eliminazione sci --");

                    String id;
                    System.out.print("Identificatore: ");
                    id = stdIn.readLine();

                    if (serverRMI.eliminaSci(id) >= 0)
                        System.out.println(
                                "Eliminazione sci con identificatore " + id + " andata a buon fine");
                    else System.out.println("Errore nell'eliminazione sci");
                } else if (service.equals("N")) {
                    System.out.println("-- Noleggio sci --");

                    String id;
                    System.out.print("Identificatore: ");
                    id = stdIn.readLine();

                    String data;
                    System.out.print("Data: ");
                    data = stdIn.readLine();

                    int giorni = -1;
                    boolean valid = false;
                    System.out.print("Giorni: ");

                    while (!valid) {
                        try {
                            giorni = Integer.parseInt(stdIn.readLine());
                        } catch (NumberFormatException nfe) {
                            System.out.print("Giorni (intero): ");
                            continue;
                        }
                        valid = true;
                    }

                    if (serverRMI.noleggiaSci(id, data, giorni) >= 0)
                        System.out.println(
                                "Noleggio sci con identificatore " + id + " in data " + data + " andata a buon fine");
                    else System.out.println("Errore nel noleggio sci");
                } else System.out.println("Servizio non disponibile");

                System.out.print("Servizio (E=Eliminazione, N:Noleggio): ");
            }
        } catch (NotBoundException nbe) {
            System.err.println("ClientRMI: il nome fornito non risulta registrato; " + nbe.getMessage());
            nbe.printStackTrace();
            System.exit(1);
        } catch (Exception e) {
            System.err.println("ClientRMI: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }
    }
}