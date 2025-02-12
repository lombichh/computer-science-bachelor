package beans;

import java.util.ArrayList;
import java.util.List;

public class NewsList {
	private List<News> newsList;
	
	public NewsList() {
		newsList = new ArrayList();
	}

	public List<News> getNewsList() {
		return newsList;
	}

	public void setNewsList(List<News> newsList) {
		this.newsList = newsList;
	}
	
}