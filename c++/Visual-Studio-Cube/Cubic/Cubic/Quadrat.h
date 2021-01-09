#pragma once
class Quadrat
{

private:

protected:
	double _length;

public:
	//Contructor
	Quadrat(double length) {
		this->_length = length;		
	}

	/// <summary>
	/// Gibt den GrundUmfang des Quadrats zur�ck
	/// </summary>
	/// <returns>GrundUmfang</returns>
	virtual double GrundUmfang() {
		return this->_length * 4;
	}

	/// <summary>
	/// Gibt die GrundFlaeche des Quadrats zur�ck
	/// </summary>
	/// <returns></returns>
	virtual double GrundFlaeche() {
		return this->_length * this->_length;

	}
};

