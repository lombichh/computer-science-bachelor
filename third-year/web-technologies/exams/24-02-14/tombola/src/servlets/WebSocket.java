package servlets;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.CopyOnWriteArraySet;

import javax.websocket.*;
import javax.websocket.server.*;

import com.google.gson.Gson;

import beans.Request;
import beans.Response;

// 1 istanza per ogni connessione, variabili di istanza per lo stato di sessione
@ServerEndpoint("/actions")
public class WebSocket {
	
	private static final Gson gson = new Gson();
	private static List<Session> giocatori = new CopyOnWriteArrayList<>();
	private static Set<Integer> numeriUsciti = new CopyOnWriteArraySet<>();
	
	private static boolean partitaInCorso = false;
	private static Thread threadPartita;
	
	private static boolean timerAvviato = false;
	private static Thread timer;
	
	@OnOpen
	public void open(Session session) {
		System.out.println("Connessione aperta");
	}
	
	@OnClose
	public void close(Session session) {
		System.out.println("Connessione Chiusa");
	}
	
	@OnError
	public void onError(Session session, Throwable throwable) {
		System.out.println("Errore");
	}
	
	@OnMessage
	public void handleMessage(Session session, String message) throws IOException {
		Request request = gson.fromJson(message, Request.class);
		
		if (request.getType() == 1) {
			// richiesta partecipazione -> check tombolaIniziata e aggiungi
			Response response = new Response();
			response.setType(1);
			
			if (partitaInCorso) response.setValue("Tombola già iniziata, attendi la fine");
			else {
				giocatori.add(session);
				response.setValue("Aggiunto alla tombola, attendi l'inizio");
				
				// numGiocatori = 5 -> start
				if (giocatori.size() == 5) {
					iniziaPartita();
				} else if (timerAvviato == false) avviaTimer();
			}
			
			session.getBasicRemote().sendText(gson.toJson(response));
		} else if (request.getType() == 2) {
			// segnalazione tombola -> termina partita e elimina giocatori
			terminaPartita();
		} else if (request.getType() == 3) {
			// ritiro -> elimina giocatore dalla partita
			for (int i = 0; i < giocatori.size(); i++) {
				if (session.getId().equals(giocatori.get(i).getId())) {
					giocatori.remove(i);
					break;
				}
			}
			
			if (giocatori.size() == 0) terminaPartita();
		}
	}
	
	private synchronized void iniziaPartita() {
		threadPartita = new Thread(() -> {
			while (numeriUsciti.size() < 90) {
				try {
					Thread.sleep(10000); // 10 secondi
					// genera numero random e invialo ai giocatori
					Response response = new Response();
					Random rand = new Random();
					
					int number = -1;
					boolean numberValid = false;
					while (!numberValid) {
						number = rand.nextInt(90);
						if (!numeriUsciti.contains(number)) numberValid = true;
					}

					response.setType(2);
					response.setValue(Integer.toString(number));
					
					for (Session giocatore : giocatori) {
						giocatore.getBasicRemote().sendText(gson.toJson(response));
					}
				} catch (InterruptedException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			
			terminaPartita();
		});
		threadPartita.start();
		partitaInCorso = true;
	}
	
	private synchronized void avviaTimer() {
		timer = new Thread(() -> {
			try {
				Thread.sleep(1000*60*5); // 5 minuti
				// inizia partita
				iniziaPartita();
				
				timerAvviato = false;
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		});
		timer.start();
	}
	
	private synchronized void terminaPartita() {
		partitaInCorso = false;
		threadPartita.interrupt();
		
		giocatori.clear();
	}
	
}