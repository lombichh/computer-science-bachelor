#include "Person.hpp"
#include <iostream>
using namespace std;

Person::Person(int age) {
    Person::age = age;
}

void Person::print_age() {
    cout << "My age is " << Person::age << " years old.";
}