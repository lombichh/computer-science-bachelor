package it.tecnologieweb.app;

public class Main {

	// creare un oggetto helloworld e assegnare il primo argomento in input alla sua proprieta' nome
	// stampare su console la frase che restituisce
	
	public static void main(String[] args) {
		HelloWorld obj = new HelloWorld();
		
		obj.setName(args[0]);
		
		System.out.println(obj.sayIt());
	}

}
