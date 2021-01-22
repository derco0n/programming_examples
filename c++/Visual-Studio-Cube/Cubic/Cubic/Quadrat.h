#pragma once
//Diese Headerdatei beschreibt (deklariert) eine Quadrat-Klasse

/// <summary>
/// Definiert ein Quadrat
/// </summary>
class Quadrat
{

private:

protected:
	double _length;

public:
	//Konstruktor
	Quadrat(double length);

	/// <summary>
	/// Gibt den GrundUmfang des Quadrats zurück
	/// </summary>
	/// <returns>GrundUmfang</returns>
	virtual double GrundUmfang();

	/// <summary>
	/// Gibt die GrundFlaeche des Quadrats zurück
	/// </summary>
	/// <returns></returns>
	virtual double GrundFlaeche();
};

