package servlets;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.CopyOnWriteArraySet;

import javax.websocket.*;
import javax.websocket.server.*;

import com.google.gson.Gson;

import beans.MyBean;

// 1 istanza per ogni connessione, variabili di istanza per lo stato di sessione
@ServerEndpoint("/actions")
public class WebSocket {
	
	private static final Gson gson = new Gson();
	private static Map<String, Integer> concurrentMap = new ConcurrentHashMap<String,Integer>(); // informazione di applicazione
	private static List<String> concurrentList = new CopyOnWriteArrayList<>(); // informazione di applicazione (CopyOnWrite per concorrenza, altrimenti synchronized)
	private static Set<String> concurrentSet = new CopyOnWriteArraySet<>(); // informazione di applicazione (CopyOnWrite per concorrenza, altrimenti synchronized)
	
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
		// messaggi di tipo diverso nella servlet
		session.getUserProperties().get("nameProperty"); // oggetto proprietà di sessione (oppure tramite variabile di istanza, synchronized)
		session.getUserProperties().put("nameProperty", "value"); // oggetto proprietà di sessione (oppure tramite variabile di istanza, synchronized)		
		
		String resultMessage;
		
		if (message.contains("value")) { // discriminare tra diversi tipi di input
			MyBean myBean = gson.fromJson(message, MyBean.class); // da json a bean
			resultMessage = gson.toJson(myBean); // da bean a json
		} else {
			MyBean myBean = gson.fromJson(message, MyBean.class); // da json a bean
			resultMessage = gson.toJson(myBean); // da bean a json
		}
		
		for (Session singleSession : session.getOpenSessions()) {
			if (singleSession.isOpen()) {
				try {
					singleSession.getBasicRemote().sendText(resultMessage); // invio risposta
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		} // invio risposta a tutti client connessi all'endpoint
	}
	
}