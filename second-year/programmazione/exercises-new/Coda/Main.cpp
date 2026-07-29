#include <iostream>
using namespace std;

const int length = 10;

struct queue {
    int data[length];
    int testa;
    int num_el;
};

queue new_queue() {
    queue tmp;
    tmp.testa = 0;
    tmp.num_el = 0;
    return tmp;
}

bool is_empty(queue Q) {
    return(Q.num_el == 0);
}

queue enqueue(queue Q, int e) {
    if (Q.num_el < length) {
        Q.data[(Q.testa + Q.num_el) % length] = e;
        Q.num_el++;
    }
    return Q;
}

queue dequeue(queue Q) {
    Q.testa = Q.testa + 1;
    Q.num_el = Q.num_el - 1;

    return Q;
}

void print_queue(queue queue) {
    for (int i = queue.testa; i < queue.testa + queue.num_el; i++) {
        cout << queue.data[i % length] << ", ";
    }
}

int main() {
    queue my_queue = new_queue();
    
    my_queue = enqueue(my_queue, 1);
    my_queue = enqueue(my_queue, 2);
    my_queue = enqueue(my_queue, 3);
    my_queue = enqueue(my_queue, 4);
    my_queue = enqueue(my_queue, 5);
    my_queue = enqueue(my_queue, 6);
    my_queue = enqueue(my_queue, 7);
    my_queue = enqueue(my_queue, 8);
    my_queue = enqueue(my_queue, 9);
    my_queue = enqueue(my_queue, 10);
    my_queue = dequeue(my_queue);
    my_queue = enqueue(my_queue, 11);
    my_queue = dequeue(my_queue);
    my_queue = enqueue(my_queue, 12);

    print_queue(my_queue);

    return 0;
}