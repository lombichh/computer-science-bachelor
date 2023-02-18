#include <iostream>
#include <cstring>
using namespace std;

#define N 25

class Automobile {
    protected:
        char modello[N];
        float consumo_100;
    public:
        Automobile(char modello[], float consumo_100) {
            strcpy(this -> modello, modello);
            this -> consumo_100 = consumo_100;
        }

        float calcola_consumi(int distanza) {
            return (consumo_100 / 100) * distanza;
        }

        float calcola_costo(int distanza, int costo) {
            return calcola_consumi(distanza) * costo;
        }
};

class AutomobileBenzina: public Automobile {
    protected:
        int capacita_serbatoio;
    public:
        AutomobileBenzina(
            char *modello, float consumo_100, 
            int capacita_serbatoio
        ):Automobile(modello, consumo_100) {
            this -> capacita_serbatoio = capacita_serbatoio;
        }

        int calcola_autonomia() {
            return capacita_serbatoio / (consumo_100 / 100);
        }
};

class AutomobileIbrida: public Automobile {
    protected:
        int capacita_serbatoio;
        int fattore_risparmio;
    public:
        AutomobileIbrida(
            char *modello, float consumo_100, 
            int capacita_serbatoio
        ):Automobile(modello, consumo_100) {
            this -> capacita_serbatoio = capacita_serbatoio;
        }

        int calcola_autonomia() {
            int autonomia_normale = capacita_serbatoio / (consumo_100 / 100);
            return autonomia_normale + autonomia_normale * ((100 - fattore_risparmio) / 100);
        }
};

class AutomobileElettrica: public Automobile {
    protected:
        int capacita_batteria;
    public:
        AutomobileElettrica(
            char *modello, float consumo_100, 
            int capacita_batteria
        ):Automobile(modello, consumo_100) {
            this -> capacita_batteria = capacita_batteria;
        }

        int calcola_autonomia() {
            return capacita_batteria / (consumo_100 / 100);
        }
};

int main() {
    char modello1[] = "Modello 1";
    
    Automobile automobile = Automobile(modello1, 50);
    cout << "Consumi: " << automobile.calcola_consumi(100);

    return 0;
}