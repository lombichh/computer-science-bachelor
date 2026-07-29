#include <iostream>
using namespace std;

const int length = 4;

struct queue {
    int data[10];
    int head;
    int itemsNum;
};

queue newQueue() {
    queue q;
    q.head = 0;
    q.itemsNum = 0;

    return q;
}

void printQueue(queue q) {
    if (q.itemsNum != 0) {
        // q is not empty
        int i = q.head;
        while (i < q.head + q.itemsNum && i < length) {
            cout << q.data[i] << ", ";
            i++;
        }
        if (i >= length) {
            for (i = 0; i < q.head + q.itemsNum - length; i++) {
                cout << q.data[i] << ", ";
            }
        }
    }

    cout << endl;
}

bool isEmpty(queue q) {
    return q.itemsNum == 0;
}

queue enqueue(queue q, int item) {
    if (q.itemsNum < length) {
        if (q.head + q.itemsNum < length)
            q.data[q.head + q.itemsNum] = item;
        else q.data[q.head + q.itemsNum - length] = item;
        q.itemsNum++;
    }
    
    return q;
}

queue dequeue(queue q) {
    if (q.itemsNum > 0) {
        if (q.head < length - 1) q.head++;
        else q.head = 0;
        q.itemsNum--;
    }

    return q;
}

int main() {
    queue myQueue = newQueue();
    printQueue(myQueue);

    myQueue = enqueue(myQueue, 4);
    myQueue = enqueue(myQueue, 5);
    myQueue = enqueue(myQueue, 6);
    myQueue = enqueue(myQueue, 7);
    printQueue(myQueue);

    myQueue = dequeue(myQueue);
    myQueue = enqueue(myQueue, 8);
    printQueue(myQueue);

    return 0;
}