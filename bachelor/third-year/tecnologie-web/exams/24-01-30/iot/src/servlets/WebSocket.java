package servlets;

import java.io.IOException;
import java.util.List;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.CopyOnWriteArraySet;

import javax.websocket.*;
import javax.websocket.server.*;

import com.google.gson.Gson;

import beans.AverageTemp;
import beans.Comando;
import beans.IotInfo;

// 1 istanza per ogni connessione, variabili di istanza per lo stato di sessione
@ServerEndpoint("/actions")
public class WebSocket {
	
	private static final Gson gson = new Gson();

	private static Set<Session> sessions = new CopyOnWriteArraySet<>();
	private static List<Integer> temps = new CopyOnWriteArrayList<>();
	
	private static Thread thread = new Thread(() -> {
		while (true) {
			try {
				Thread.sleep(1000*60*60);
				
				for (Session session : sessions) {
					if (session.isOpen()) {
						try {
							if (temps.size() > 0) {
								int sumTemps = 0;
								for (int temp : temps) {
									sumTemps += temp;
								}
								int averageTempValue = sumTemps/temps.size();
								
								AverageTemp averageTemp = new AverageTemp();
								averageTemp.setValue(averageTempValue);
								
								session.getBasicRemote().sendText(gson.toJson(averageTemp));
								
								temps.clear();
							}
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				}
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	});
	
	@OnOpen
	public void open(Session session) {
		System.out.println("Connessione aperta");
		
		sessions.add(session);
		if (sessions.size() == 1) thread.start();
	}
	
	@OnClose
	public void close(Session session) {
		System.out.println("Connessione Chiusa");
		
		sessions.remove(session);
	}
	
	@OnError
	public void onError(Session session, Throwable throwable) {
		System.out.println("Errore");
	}
	
	@OnMessage
	public void handleMessage(Session session, String message) throws IOException {
		if (message.contains("temp")) {
			IotInfo iotInfo = gson.fromJson(message, IotInfo.class);
			temps.add(iotInfo.getTemp());
		} else {
			Comando comando = gson.fromJson(message, Comando.class);
			for (Session singleSession : sessions) {
				if (singleSession.getId().equals(comando.getSessionId()) && singleSession.isOpen()) {
					try {
						singleSession.getBasicRemote().sendText(gson.toJson(comando));
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
	
}