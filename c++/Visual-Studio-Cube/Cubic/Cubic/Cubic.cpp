// Cubic.cpp : Diese Datei enthält die Funktion "main". Hier beginnt und endet die Ausführung des Programms.
//

#include <iostream>
//#include "Quadrat.h"
//#include "Rechteck.h"
#include "Quader.h"

int main()
{
    //std::cout << "Hello World!\n";
    std::cout << "Bitte L\x84nge eingeben.\n";
    double len = 0.0;
    std::cin >> len;

    std::cout << "Erzeuge Quadrat mit der Kantenl\x84nge von: " << len << "\n";
    Quadrat* nQuadrat = new Quadrat(len);
    std::cout << "Fl\x84\x63he: " << nQuadrat->GrundFlaeche() << "\n";
    std::cout << "Umfang: " << nQuadrat->GrundUmfang() << "\n";

    delete nQuadrat;  //Detroy the Quadrat-Object
    
    std::cout << "\n";
    //#####

    std::cout << "Bitte Breite eingeben.\n";
    double wid = 0.0;
    std::cin >> wid;

    std::cout << "Erzeuge Rechteck mit der L\x84nge von " << len << " und der Breite von " << wid << "\n";
    Rechteck* nRechteck = new Rechteck(len, wid);
    
    std::cout << "Fl\x84\x63he: " << nRechteck->GrundFlaeche() << "\n";
    std::cout << "Umfang: " << nRechteck->GrundUmfang() << "\n";

    delete nRechteck;

    std::cout << "\n";
    //######

    std::cout << "Bitte H\224he eingeben.\n";
    double height = 0.0;
    std::cin >> height;

    std::cout << "Erzeuge Quader mit der L\x84nge von " << len << ", der Breite von " << wid << " und der H\224he von " << height << "\n";
    Quader* nQuader = new Quader(len, wid, height);

    std::cout << "Fl\x84\x63he: " << nQuader->GrundFlaeche() << "\n";
    std::cout << "Umfang: " << nQuader->GrundUmfang() << "\n";
    std::cout << "Volumen: " << nQuader->Volumen() << "\n";

    delete nQuader;


    return 0;
}

// Programm ausführen: STRG+F5 oder Menüeintrag "Debuggen" > "Starten ohne Debuggen starten"
// Programm debuggen: F5 oder "Debuggen" > Menü "Debuggen starten"

// Tipps für den Einstieg: 
//   1. Verwenden Sie das Projektmappen-Explorer-Fenster zum Hinzufügen/Verwalten von Dateien.
//   2. Verwenden Sie das Team Explorer-Fenster zum Herstellen einer Verbindung mit der Quellcodeverwaltung.
//   3. Verwenden Sie das Ausgabefenster, um die Buildausgabe und andere Nachrichten anzuzeigen.
//   4. Verwenden Sie das Fenster "Fehlerliste", um Fehler anzuzeigen.
//   5. Wechseln Sie zu "Projekt" > "Neues Element hinzufügen", um neue Codedateien zu erstellen, bzw. zu "Projekt" > "Vorhandenes Element hinzufügen", um dem Projekt vorhandene Codedateien hinzuzufügen.
//   6. Um dieses Projekt später erneut zu öffnen, wechseln Sie zu "Datei" > "Öffnen" > "Projekt", und wählen Sie die SLN-Datei aus.
