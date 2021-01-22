#pragma once
//Diese Headerdatei beschreibt(deklariert) eine Rechteck - Klasse welche von Quadrat erbt.

#include "Quadrat.h"
class Rechteck : public Quadrat
    {
    private:


    protected:
        double _width;  //Zus�tzliche Eigenschaft eine Rechtecks (Breite und L�nge k�nnen unterschiedlcih sein)


    public:
        /// <summary>
        /// Creates a new "Rechteck" instance
        /// </summary>
        /// <param name="length"></param>
        /// <param name="width"></param>
        /// <returns></returns>
        Rechteck(double length, double width);

        /// <summary>
        /// Gibt den GrundUmfang des Rechtecks zur�ck
        /// </summary>
        /// <returns>GrundUmfang des Rechtecks</returns>
        double GrundUmfang() override;

        /// <summary>
        /// Gibt die Fl�che des Rechtecks zur�ck
        /// </summary>
        /// <returns>Fl�che des Rechtecks</returns>
        double GrundFlaeche() override;

    };

