# Beschreibung

Sie finden hier eine Sammlung von Skripten die für die Überwachung verschiedenster Funktionen und Einstellungen in 3CX entwickelt wurden.
Zur besseren Übersicht wurden für die jeweiligen Skipte Unterordner erstellt. In den Ordner finden Sie jeweils eine kurze Beschreibung, sowie das Skript als Bash-File und im rsf-Format zum einfachen Import in Riversuite.
Eine Anleitung für den Import finden Sie unter folgendem Link


Über denn lokale installieren RiverSuite Agenten für Linux können alle Zugangsdaten und Parameter direkt aus dem System ohne weitere Anpassungen automatisiert in Skripte übergeben werden importiert werden.

Diese Lösung eignet sich ideal für das Deployment über für mehrere Systeme über die "Checkpaketveraltung" in RiverSuite. Hierzu muss dann nur noch der RiverSuite Agent für Linux verteilt werden und alle Checks werden komplett automatisiert und ohne weitere Anpassung für alle überwachten 3CX Serversysteme verteilt.
Eine entsprechende Anleitung finden Sie <a href="https://github.com/aconitas/3CX-Monitoring/blob/main/Scripts%20(use%20with%20local%20Linux%20Monitoring%20Agent)/Checkpaketverwaltung.md">hier</a>.



Zum einfachen Import der Skripte haben wir unsere Original-Dateien im jeweiligen Ordner im rsf Format abgelegt

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
