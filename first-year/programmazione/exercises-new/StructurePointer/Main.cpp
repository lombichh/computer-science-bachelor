#include <iostream>
using namespace std;

struct fivefields {
    int one;
    int two;
    int three;
    int four;
    int five;
};


int main() {
    fivefields P;

    fivefields* q = &P;
    cin >> (*q).one >> (*q).two >> (*q).three >> (*q).four >> (*q).five;

    /* or
    int* q;

    q = &(P.one);
    cin >> *q;
    q = &(P.two);
    cin >> *q;
    q = &(P.three);
    cin >> *q;
    q = &(P.four);
    cin >> *q;
    q = &(P.five);
    cin >> *q; */

    cout << P.one << P.two << P.three << P.four << P.five;

    return 0;
}