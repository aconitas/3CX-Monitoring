# Beschreibung

Sie finden hier eine Sammlung von Skripten die für die Überwachung verschiedenster Funktionen in 3CX entwickelt wurden.
Über denn lokale installieren RiverSuite Agenten für Linux können alle Zugangsdaten und Parameter direkt aus dem System ohne Eingabe vollautomatisch importiert werden. Diese Lösung ist am einfachsten zu implementieren, da keine weiteren Zugangsdaten und Paramater benötigt werden und eignet sich ideal für das Deployment über die "Checkpaketveraltung" in RiverSuite. Hierzu muss dann nur noch der RiverSuite Agent für Linux verteilt werden und alle Checks werden komplett automatisiert und ohne weitere Anpassung für alle überwachten 3CX Serversysteme verteilt 

# Voraussetzungen 
- Linux Debian OS mit SSH Zugriff
- Installlation 3CX Phone System
- Installation RiverSuite Agent für Linux

Die Skipte sind für diesen Agenten optimiert.

# Arbeitsweise
Als erstes Skript muss der "001 - Auth Service Check" eingerichtet werden. Dieser führt für alle anderen Checks die Authentifzierung am 3CX Server über die 3CX Managment Console durch. Es müssen keine weiteren Parameter hinterlegt oder angepasst. werden


Die Skripte müssen unter Monitoring -> Einstellungen -> Skript-Einstellungen hinterlegt werden

Die Exit Codes müssen laut Screenshot konfiguriert werden:
![Skript Einstellungen](./_images/image-20221128213217-14.png)
