#pragma once
#include "Rechteck.h"
class Quader :  public Rechteck
{
private:

protected:
	double _height;

public:
	/// <summary>
	/// Creates a new "Quader object"
	/// </summary>
	/// <param name="length"></param>
	/// <param name="width"></param>
	/// <param name="height"></param>
	/// <returns></returns>
	Quader(double length, double width, double height) :Rechteck(length, width) { //Constructor
		this->_height = height;
	}

	/// <summary>
	/// Gibt das Volumen des Quaders zurück
	/// </summary>
	/// <returns></returns>
	double Volumen() {
		return this->GrundFlaeche() * this->_height;
	}
};

