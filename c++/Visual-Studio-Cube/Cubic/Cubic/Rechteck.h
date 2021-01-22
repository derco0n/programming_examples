#pragma once
//Diese Headerdatei beschreibt(deklariert) eine Rechteck - Klasse welche von Quadrat erbt.

#include "Quadrat.h"
class Rechteck : public Quadrat
    {
    private:


    protected:
        double _width;  //Zusätzliche Eigenschaft eine Rechtecks (Breite und Länge können unterschiedlcih sein)


    public:
        /// <summary>
        /// Creates a new "Rechteck" instance
        /// </summary>
        /// <param name="length"></param>
        /// <param name="width"></param>
        /// <returns></returns>
        Rechteck(double length, double width);

        /// <summary>
        /// Gibt den GrundUmfang des Rechtecks zurück
        /// </summary>
        /// <returns>GrundUmfang des Rechtecks</returns>
        double GrundUmfang() override;

        /// <summary>
        /// Gibt die Fläche des Rechtecks zurück
        /// </summary>
        /// <returns>Fläche des Rechtecks</returns>
        double GrundFlaeche() override;

    };

