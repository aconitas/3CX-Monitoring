# SSL Cert Check
Diese Skript prüft die aktuelle Laufzeit des SSL Zertifikats und gibt den Name des Zertifikatsausstellers an.
Wir haben diese Skript entwickelt, da über den **RiverSuite** bereits enthaltenen SSL Check der Domain Name bei jedem Kunden nochmals individuell hinterlegt werden müsste. Dies scheidet hier aus, der der 3CX FDQN direkt aus der 3CX Datenbank ausgelesen wird.

# Besonderheiten zur Konfiguration
Die Schwellwerte für Warnungen und Fehler können über Variablen global konfiguriert werden

![RiverSuite_Inventory_GBF1BEwnuk](https://user-images.githubusercontent.com/119604651/208267493-7f16d196-addf-4829-891e-e50aeb2b3a50.png)

möglicher Output:

Check erfolgreich:
![4Edg95uW6g](https://user-images.githubusercontent.com/119604651/208267334-a65855be-c18f-4ed2-af1d-10a566d3a348.png)
Check mit Warnung:
![cFRxWuHjwJ](https://user-images.githubusercontent.com/119604651/208267900-62e5d685-081b-4235-a329-7660cfb11764.png)
Check mit Fehler:
![BC3aw7YS4D](https://user-images.githubusercontent.com/119604651/208267446-46477f01-df5b-40ca-b4c9-e1157eedf0d3.png)

mögliche Fehlerquellen:
- Server nicht erreichbar
- Zertifikat abgelaufen
- Zertifkatskette unvollständig
