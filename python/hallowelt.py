# Python Demo programm
# Kommentare werden mit # voran geschrieben.

print("Hallo Welt") # Text ausgeben

zahl = 0  # variable "zahl" definieren und auf den Wert 0 setzen
while zahl < 100:  # Schleife: Solange zahl kleiner als 100 ist.
    # Alles was hier eingerückt ist, passiert in der Schleife. Sobald die Einrückung aufgehoben wird, ist der Schleifenkörper geschlossen.
    print("Zahl hat nun den Wert: " + str(zahl))  # Den Wert von Zahl ausgeben. Damit dieser so ausgegeben werden muss die zahl zunächst mit str() in einen string konvertiert werden
    zahl+=1  # den Wert von Zahl um 1 erhöhen
print("Programmende")
