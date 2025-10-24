package beans;

public class User {
	private String username;
	private String password;
	private int type; // 1 -> giornalista, 2 -> direttore
	
	public User() {
		this.username = "";
		this.password = "";
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}
}