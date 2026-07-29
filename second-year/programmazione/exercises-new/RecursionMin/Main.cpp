#include <iostream>
#include <ctime>
#include <cstdlib>
using namespace std;

struct list {
    int val;
    list* next;
};
typedef list* ptr_list;

void printList(ptr_list head) {
    while (head != NULL) {
        cout << head -> val << ", ";
        head = head -> next;
    }

    cout << endl;
}

ptr_list head_insert(ptr_list head, int item){
    ptr_list tmp_head;
    tmp_head = new list;
    tmp_head -> val = item;
    tmp_head -> next = head;
    return(tmp_head);
}

ptr_list generate_list(int n, int max){
    ptr_list head = NULL;

    for (int i = 0; i < n; i++) {
        head = head_insert(head, rand() % max);
    }

    return head;
}

int min_list(ptr_list head) {
    if (head -> next == NULL) return head -> val;
    else {
        int min_sublist = min_list(head -> next);
        if (head -> val < min_sublist) return head -> val;
        else return min_sublist;
    }
}

int main() {
    srand(time(0));

    ptr_list list1 = generate_list(10, 10);
    printList(list1);
    cout << min_list(list1);

    return 0;
}