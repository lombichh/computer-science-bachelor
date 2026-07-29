#include <cstring>
#include <iostream>
using namespace std;

int const titleLength = 30;

struct book {
    char title[titleLength];
    int price;
    int copies;
    book *nextBook;
};

void createBookList(book *firstBook) {
    strcpy(firstBook -> title, "Title1");
    firstBook -> price = 11;
    firstBook -> copies = 1;
    
    book *book2;
    strcpy(book2 -> title, "Title2");
    book2 -> price = 12;
    book2 -> copies = 2;
    
    book *book3;
    strcpy(book3 -> title, "Title3");
    book3 -> price = 13;
    book3 -> copies = 3;

    firstBook -> nextBook = book2;
    book2 -> nextBook = book3;
}

void printBookList(book *firstBook) {
    book* bookIterator = firstBook;
    while (bookIterator != NULL) {
        cout << bookIterator -> title << ", "
         << bookIterator -> price << ", "
         << bookIterator -> copies << endl;
        bookIterator = bookIterator -> nextBook;
    }
}

void buyBook(book *firstBook, char bookTitle[]) {
    book* bookIterator = firstBook;
    while (bookIterator != NULL) {
        if (strcmp(bookIterator -> title, bookTitle) == 0) {
            bookIterator -> copies--;
        }
        bookIterator = bookIterator -> nextBook;
    }
}

int averagePrice(book *firstBook) {
    book* bookIterator = firstBook;

    int sum = 0;
    int n = 0;

    while (bookIterator != NULL) {
        sum += bookIterator -> price;
        n++;
        bookIterator = bookIterator -> nextBook;
    }

    return (sum / n);
}

void moreExpBook(book *firstBook) {
    book *bookIterator = firstBook;

    book *moreExpBook = firstBook;

    while (bookIterator != NULL) {
        if (bookIterator -> price > moreExpBook -> price)
            moreExpBook = bookIterator;
        bookIterator = bookIterator -> nextBook;
    }

    cout << moreExpBook -> title << ", " << moreExpBook -> price;
}

int main() {
    book firstBook = {"Title1", 11, 1};
    book secondBook = {"Title2", 12, 2};
    book thirdBook = {"Title3", 13, 3};

    firstBook.nextBook = &secondBook;
    secondBook.nextBook = &thirdBook;
    thirdBook.nextBook = NULL;

    book *pointer = &firstBook;

    printBookList(pointer);

    char title[] = "Title2";
    buyBook(pointer, title);

    printBookList(pointer);

    cout << averagePrice(pointer) << endl;

    moreExpBook(pointer);

    return 0;
}