#include <iostream>
#include <cstring>
using namespace std;

const int max_length = 25;

struct incontro {
    int orario_inizio;
    char titolo_incontro[max_length];
    char nome_relatore[max_length];
};

const int n = 12;

class Conferenza {
    protected:
        int orario_inizio;
        int orario_fine;
        int orario_pranzo;
        incontro incontri[n];
        int num_incontri;

    public:
        Conferenza(int orario_inizio, int orario_fine, int orario_pranzo,
                    incontro incontri[], int num_incontri) {
            this -> orario_inizio = orario_inizio;
            this -> orario_fine = orario_fine;
            this -> orario_pranzo = orario_pranzo;
            
            for (int i = 0; i < num_incontri; i++) {
                (this -> incontri)[i] = incontri[i];
            }
            this -> num_incontri = num_incontri;
        }

        int num_slot_disponibili() {
            return orario_fine - orario_inizio - 1 - num_incontri;
        }

        bool controlla_orario(int orario) {
            return orario >= this -> orario_inizio
                && orario < this -> orario_fine
                && orario != orario_pranzo; 
        }

        bool controlla_slot(int orario) {
            if (controlla_orario(orario)) {
                bool available = true;
                int i = 0;
                while (i < this -> num_incontri && available) {
                    if (orario == incontri[i].orario_inizio) available = false;
                    else i++;
                }
                return available;
            } else return false;
        }

        void aggiungi_incontro(
            int orario_inizio, char titolo_incontro[], char nome_relatore[]
        ) {
            if (controlla_slot(orario_inizio) && num_incontri < n) {
                incontro nuovo_incontro;
                nuovo_incontro.orario_inizio = orario_inizio;
                strcpy(nuovo_incontro.titolo_incontro, titolo_incontro);
                strcpy(nuovo_incontro.nome_relatore, nome_relatore);

                incontri[num_incontri] = nuovo_incontro;
                num_incontri++;
            }
        }
};

int main() {
    incontro incontro1 = {8, "Incontro_1", "Relatore_1"};
    incontro incontro2 = {9, "Incontro_2", "Relatore_2"};
    incontro incontro3 = {11, "Incontro_3", "Relatore_3"};
    incontro incontro4 = {12, "Incontro_4", "Relatore_4"};
    incontro incontro5 = {14, "Incontro_5", "Relatore_5"};

    incontro incontri[] = {incontro1, incontro2, incontro3, incontro4, incontro5};

    Conferenza conferenza = Conferenza(8, 18, 13, incontri, 5);

    return 0;
}