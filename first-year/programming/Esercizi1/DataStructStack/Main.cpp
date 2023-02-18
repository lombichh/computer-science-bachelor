#include <iostream>
using namespace std;

const int length = 10;

struct stack {
    int data[length];
    int top;
};

void printStack(stack s) {
    int i = length - 1;

    while (i >= s.top) {
        cout << s.data[i] << ", ";
        i--;
    }
    cout << endl;
}

stack newStack() {
    stack newStack;
    newStack.top = length;
    return newStack;
}

bool isEmpty(stack s) {
    return (s.top == length);
}

stack push(stack s, int item) {
    if (s.top != 0) {
        s.top--;
        s.data[s.top] = item;
    };
    return s;
}

stack pop(stack s) {
    if (s.top != length) s.top++;
    return s;
}

int main() {
    // test
    stack myStack = newStack();
    myStack = pop(myStack);
    myStack = push(myStack, 1);
    myStack = push(myStack, 2);
    myStack = push(myStack, 3);
    myStack = push(myStack, 4);
    myStack = push(myStack, 5);
    myStack = push(myStack, 6);
    myStack = push(myStack, 7);
    myStack = push(myStack, 8);
    myStack = push(myStack, 9);
    myStack = push(myStack, 10);
    myStack = push(myStack, 11);

    printStack(myStack);

    myStack = pop(myStack);
    
    printStack(myStack);

    return 0;
}