#include "Rechteck.h"

//Diese .cpp implementiert die Rechteck-Klasse welche in der Header-Datei "Rechteck.h" deklariert wird

//Konstruktor
Rechteck::Rechteck(double length, double width) 
    : Quadrat(length) {  // Da Rechteck von Quadrat erbt, muss der Basis-Konstruktor (von Quadrat) aufgerufen werden.
        this->_width = width;
        }


double Rechteck::GrundUmfang() {
    return 2 * this->_length + 2 * this->_width;
}

double Rechteck::GrundFlaeche() {
    return this->_width * this->_length;
}
