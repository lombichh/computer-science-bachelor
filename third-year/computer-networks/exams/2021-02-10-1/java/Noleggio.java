public class Noleggio {
    public String id, data, modello, nomeFileFoto;
    public int giorni, costoGiornaliero;

    public Noleggio(String id, String data, int giorni, String modello, int costoGiornaliero, String nomeFileFoto) {
        this.id = id;
        this.data = data;
        this.giorni = giorni;
        this.modello = modello;
        this.costoGiornaliero = costoGiornaliero;
        this.nomeFileFoto = nomeFileFoto;
    }
}