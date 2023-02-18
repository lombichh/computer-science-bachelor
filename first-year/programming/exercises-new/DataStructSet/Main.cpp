#include <iostream>
using namespace std;

const int length = 10;

struct set {
    int data[length];
    int top;
};

set newSet() {
    set newSet;
    newSet.top = -1;
    return newSet;
}

void printSet(set s) {
    int i = 0;

    while (i <= s.top) {
        cout << s.data[i] << ", ";
        i++;
    }

    cout << endl;
}

set addItem(set &s, int item) {
    if (s.top < (length - 1)) {
        s.top++;
        s.data[s.top] = item;
    }
    return s;
}

bool isIn(set s, int item) {
   /*  bool found = false;

    int i = 0;
    while (i <= s.top && !found) {
        if (s.data[i] == item) found = true;
        i++;
    }

    return found; */

    bool found = false;

    if (s.top != -1) {
        int start = 0;
        int end = s.top;
        int m;
        while (start <= end && !found) {
            m = (start + end) / 2;
            if (s.data[m] == item) found = true;
            else if (s.data[m] < item) start = m + 1;
            else end = m - 1;
        }
    }

    return found;
}

set instersectSet(set s1, set s2) {
    set s3 = newSet();

    int i = 0;
    while (s3.top < length  && i <= s2.top) {
        if (isIn(s1, s2.data[i])) addItem(s3, s2.data[i]);
        i++;
    }

    return s3;
}

set unionSet(set s1, set s2) {
    set s3 = s1;

    int i = 0;
    while (s3.top < length  && i <= s2.top) {
        if (!isIn(s3, s2.data[i])) addItem(s3, s2.data[i]);
        i++;
    }

    return s3;
}

int main() {
    // test
    set mySet1 = newSet();

    printSet(mySet1);

    addItem(mySet1, 1);
    addItem(mySet1, 2);
    addItem(mySet1, 3);
    addItem(mySet1, 4);
    addItem(mySet1, 5);
    addItem(mySet1, 6);

    set mySet2 = newSet();

    printSet(mySet2);

    addItem(mySet2, 5);
    addItem(mySet2, 6);
    addItem(mySet2, 11);
    addItem(mySet2, 10);
    addItem(mySet2, 12);
    addItem(mySet2, 13);
    addItem(mySet2, 14);
    addItem(mySet2, 15);

    printSet(mySet1);
    printSet(mySet2);

    cout << isIn(mySet1, 4) << endl << isIn(mySet1, 11) << endl;

    set mySet3 = instersectSet(mySet1, mySet2);

    printSet(mySet3);

    set mySet4 = unionSet(mySet1, mySet2);
    
    printSet(mySet4);
    
    return 0;
}