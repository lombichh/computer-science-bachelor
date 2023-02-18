#include <iostream>
using namespace std;

struct sala {
    int num_posti;
    int num_prenotati;
    bool is_3d;
};

const int num_sale = 5;

class MultiSala {
    protected:
        int prezzo_normale;
        int prezzo_3d;
        sala sale[num_sale];

    public:
        MultiSala(int prezzo_normale, int prezzo_3d, sala sale[]) {
            this -> prezzo_normale = prezzo_normale;
            this -> prezzo_3d = prezzo_3d;
            for (int i = 0; i < num_sale; i++) {
                (this -> sale)[i] = sale[i];
            }
        }

        bool prenota_posto(int i) {
            sala current_sala = (this -> sale)[i];
            if (current_sala.num_posti > current_sala.num_prenotati) {
                current_sala.num_prenotati++;
                return false;
            } else return true;
        }

        int conta_ticket(bool sale_3d) {
            int counter = 0;
            for (int i = 0; i < num_sale; i++) {
                sala current_sala = (this -> sale)[i];
                if (sale_3d && current_sala.is_3d) counter += current_sala.num_posti;
                else if (!sale_3d && !current_sala.is_3d) counter += current_sala.num_posti;
            }
            return counter;
        }

        int incasso_totale() {
            int tickets = conta_ticket(false);
            int tickets_3d = conta_ticket(true);

            return (tickets * prezzo_normale + tickets_3d * prezzo_3d);
        }
};

struct ristorante {
    int num_consumazioni;
    int costo_menu_fisso;
};

const int num_ristoranti = 3;

class MultiSalaPlus: public MultiSala {
    protected:
        ristorante ristoranti[num_ristoranti];
    public:
        MultiSalaPlus(int prezzo_normale, int prezzo_3d,
                    sala sale[num_sale], ristorante ristoranti[]):
                    MultiSala(prezzo_normale, prezzo_3d, sale) {
            for (int i = 0; i < num_ristoranti; i++) {
                (this -> ristoranti)[i] = ristoranti[i];
            }
        }

        int incasso_totale() {
            int tot = MultiSala::incasso_totale();

            for (int i = 0; i < num_ristoranti; i++) {
                tot += ristoranti[i].num_consumazioni * ristoranti -> costo_menu_fisso;
            }

            return tot;
        }
};

int main() {
    sala sala1 = {100, 80, false};
    sala sala2 = {150, 90, true};
    sala sala3 = {80, 80, true};
    sala sala4 = {110, 20, false};
    sala sala5 = {100, 80, false};
    sala sale[num_sale] = {sala1, sala2, sala3, sala4, sala5};

    MultiSala multi_sala(8, 10, sale);

    cout << multi_sala.prenota_posto(2) << endl;
    cout << multi_sala.conta_ticket(true) << endl;
    cout << multi_sala.incasso_totale() << endl;

    ristorante ristorante1 = {100, 10};
    ristorante ristorante2 = {150, 15};
    ristorante ristorante3 = {80, 12};
    ristorante ristoranti[num_ristoranti] =
        {ristorante1, ristorante2, ristorante3};

    MultiSalaPlus multi_sala_plus = MultiSalaPlus(8, 10, sale, ristoranti);

    cout << multi_sala_plus.incasso_totale() << endl;

    return 0;
}