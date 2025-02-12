package servlets;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import beans.News;
import beans.NewsList;
import beans.Request;

// 1 istanza condivisa da tutte le richieste (thread), variabili di istanza per lo stato di applicazione
public class GiornaleServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private Gson gson;
	private static Map<String, NewsList> giornalistiNewsList = new HashMap<>();
	private static Object lock = new Object();

	@Override
	public void init() throws ServletException {
		// richiamato 1 sola volta, no concorrenza
		gson = new Gson();
		
		// TODO: inserisci giornalisti news list
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String body = "";
		String line;
        BufferedReader reader = req.getReader();
        while ((line = reader.readLine()) != null) {
        	body += line;
        }
        
		Request request = gson.fromJson(body, Request.class);
		
		if (request.getType() == 1) {
			// richiesta news
			synchronized (lock) {
				List<News> newsListTemp = new ArrayList();
				
				for (String giornalista : giornalistiNewsList.keySet()) {
					for (int j = 0; j < giornalistiNewsList.get(giornalista).getNewsList().size(); j++) {
						newsListTemp.addAll(giornalistiNewsList.get(giornalista).getNewsList());
					}
				}

				NewsList newsList = new NewsList();
				newsList.setNewsList(newsListTemp);
				
				PrintWriter out = resp.getWriter();
				out.println(gson.toJson(newsList)); // scrivere nel body della risposta
			}
		} else if (request.getType() == 2) {
			// richiesta aggiornamento news
			synchronized(lock) {
				try {
					lock.wait();
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				List<News> newsListTemp = new ArrayList();
				
				for (String giornalista : giornalistiNewsList.keySet()) {
					for (int j = 0; j < giornalistiNewsList.get(giornalista).getNewsList().size(); j++) {
						newsListTemp.addAll(giornalistiNewsList.get(giornalista).getNewsList());
					}
				}

				NewsList newsList = new NewsList();
				newsList.setNewsList(newsListTemp);
				
				PrintWriter out = resp.getWriter();
				out.println(gson.toJson(newsList)); // scrivere nel body della risposta
			}
		} else if (request.getType() == 3) {
			// aggiungi notizia
			synchronized(lock) {
				News newNews = new News();
				newNews.setGiornalista(request.getGiornalista());
				newNews.setNotizia(request.getNotizia());
				
				List<News> newsListTemp = new ArrayList();
				newsListTemp.addAll(giornalistiNewsList.get(request.getGiornalista()).getNewsList());
				newsListTemp.add(newNews);
				NewsList newsList = new NewsList();
				newsList.setNewsList(newsListTemp);
				
				giornalistiNewsList.put(request.getGiornalista(), newsList);
				
				lock.notifyAll();
			}
		} else if (request.getType() == 4) {
			// elimina ultima notizia
			synchronized(lock) {
				List<News> newsListTemp = new ArrayList();
				newsListTemp.addAll(giornalistiNewsList.get(request.getGiornalista()).getNewsList());
				newsListTemp.remove(newsListTemp.size() - 1);
				NewsList newsList = new NewsList();
				newsList.setNewsList(newsListTemp);
				
				giornalistiNewsList.put(request.getGiornalista(), newsList);
				
				lock.notifyAll();
			}
		}
	}
}