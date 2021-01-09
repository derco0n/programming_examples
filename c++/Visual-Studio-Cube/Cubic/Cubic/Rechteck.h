#pragma once
#include "Quadrat.h"
class Rechteck : public Quadrat
    {
    private:


    protected:
        double _width;


    public:
        /// <summary>
        /// Creates a new "Rechteck" instance
        /// </summary>
        /// <param name="length"></param>
        /// <param name="width"></param>
        /// <returns></returns>
        Rechteck(double length, double width):Quadrat(length)  //Constructor
        {
            this->_width = width;
        }

        /// <summary>
        /// Gibt den GrundUmfang des Rechtecks zur�ck
        /// </summary>
        /// <returns>GrundUmfang des Rechtecks</returns>
        double GrundUmfang() override {
            return 2 * this->_length + 2 * this->_width;
        }

        /// <summary>
        /// Gibt die Fl�che des Rechtecks zur�ck
        /// </summary>
        /// <returns>Fl�che des Rechtecks</returns>
        double GrundFlaeche() override {
            return this->_width * this->_length;
        }

    };

