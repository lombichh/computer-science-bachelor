#include <iostream>
using namespace std;

struct node {
    int val;
    int next;
};

void printList(node list[]) {
    node currentNode = list[0];

    while (currentNode.next != -1) {
        cout << currentNode.val << ", ";
        currentNode = list[currentNode.next];
    }

    cout << currentNode.val << endl;
}

void setListNode(node list[], int index, int val, int next) {
    node n = {val, next};
    list[index] = n;
}

void reverseList(node list[], int length) {
    int orderedList[length];

    // create orderedList
    int i = 0;
    node currentNode = list[0];
    while (currentNode.next != -1) {
        orderedList[i] = currentNode.val;
        i++;
        currentNode = list[currentNode.next];
    }
    orderedList[i] = currentNode.val;

    int j = 0;
    while (list[j].next != -1) {
        list[j].val = orderedList[i];
        i--;
        j = list[j].next;
    }
    list[j].val = orderedList[i];
}

int main() {
    const int length = 5;
    node nodeList[length];

    setListNode(nodeList, 0, 1, 4);
    setListNode(nodeList, 4, 5, 2);
    setListNode(nodeList, 2, 3, -1);

    printList(nodeList);

    reverseList(nodeList, length);

    printList(nodeList);

    return 0;
}