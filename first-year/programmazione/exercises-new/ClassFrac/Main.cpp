#include <iostream>
using namespace std;

class frac {
private:
    int num;
    int den;
public:
    int get_num() {
        return num;
    }
    int get_den() {
        return den;
    }
    
    void stampa(frac f) {
        if (num == 0 && den == 0) cout << "Valore indeterminato";
        else if (den == 0) cout << "Valore impossibile";
        else cout << ((double) num) / den << endl;
    }

    frac(int n, int d) {
        num = n;
        den = d;
    }
};

frac moltiplica(frac f1, frac f2) {
    frac f3 = frac(
        f1.get_num() * f2.get_num(),
        f1.get_den() * f2.get_den()
    );
    return f3;
}

frac inverso(frac f1) {
    frac f2 = frac(f1.get_den(), f1.get_num());
    return f2;
}

int main() {
    frac f1 = frac(5, 3);
    frac f2 = frac(6, 7);

    stampa(moltiplica(f1, f2));
    cout << endl;
    stampa(inverso(f1));

    return 0;
}