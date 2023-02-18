#include <iostream>
using namespace std;

class circle {
    const double pi = 3.14;
    
private:
    double raggio;
    double diametro;

public:
    void set_raggio(double r) {
        raggio = r;
    }
    double get_raggio() {
        return raggio;
    }

    void set_diametro(double d) {
        diametro = d;
    }
    double get_diametro() {
        return diametro;
    }

    double circonferenza() {
        return(2 * pi * raggio);
    }

    double area() {
        return(pi * raggio * raggio);
    }
};

int main() {
    circle c;
    c.set_raggio(3);
    c.set_diametro(10);

    cout << c.area() << ", " << c.circonferenza();

    return 0;
}