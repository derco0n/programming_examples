#include "Quader.h"

//Konstruktor
Quader::Quader(double length, double width, double height) 
	:Rechteck(length, width) { 
		this->_height = height;
}

/// <summary>
/// Gibt das Volumen des Quaders zurück
/// </summary>
/// <returns></returns>
double Quader::Volumen() {
	return this->GrundFlaeche() * this->_height;
}