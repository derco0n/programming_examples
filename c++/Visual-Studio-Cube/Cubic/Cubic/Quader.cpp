#include "Quader.h"

//Konstruktor
Quader::Quader(double length, double width, double height) 
	:Rechteck(length, width) { 
		this->_height = height;
}

/// <summary>
/// Gibt das Volumen des Quaders zur�ck
/// </summary>
/// <returns></returns>
double Quader::Volumen() {
	return this->GrundFlaeche() * this->_height;
}