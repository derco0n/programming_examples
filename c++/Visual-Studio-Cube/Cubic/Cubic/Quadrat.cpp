#include "Quadrat.h"

//Diese .cpp implementiert die Quadrat-Klasse welche in der Header-Datei "Quadrat.h" deklariert wird

//Konstruktor
Quadrat::Quadrat(double length) {
	this->_length = length;
	}

double Quadrat::GrundUmfang() {
	return this->_length * 4;
	}	

double Quadrat::GrundFlaeche() {
	return this->_length * this->_length;
	}