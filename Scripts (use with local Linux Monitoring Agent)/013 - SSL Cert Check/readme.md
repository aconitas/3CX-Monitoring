# SSL Cert Check
Diese Skript prüft die aktuelle Laufzeit des SSL Zertifikats und gibt den Name des Zertifikatsausstellers an

# Besonderheiten zur Konfiguration
Die Schwellwerte für Warnungen und Fehler können über Variablen global konfiguriert werden


möglicher Output:
Check erfolgreich:
![4Edg95uW6g](https://user-images.githubusercontent.com/119604651/208267334-a65855be-c18f-4ed2-af1d-10a566d3a348.png)
Check mit Warnung:

Check mit Fehler:
![4Edg95uW6g](https://user-images.githubusercontent.com/119604651/208267410-2f76b942-1d5c-4c70-8afb-50ae1ef19796.png)
Mögliche Fehlerquellen sind
- Server nicht erreichbar
- Zertifikat abgelaufen
- Zertifkatskette unvollständig
