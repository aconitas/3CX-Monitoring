# Beschreibung

Sie finden hier eine Sammlung von Skripten, die für die Überwachung verschiedenster Funktionen und Einstellungen in 3CX entwickelt wurden.

Zur besseren Übersicht wurden für die einzelnen Skripte mit weiteren Informationen in entsprechenden Unterordnern abgelegt. In den jeweiligen Ordnern finden Sie eine kurze Beschreibung, sowie das Skript als Bash-File. Da unser Schwerpunkt auf dem Monitoring-System von **RiverSuite** liegt haben wir, zum einfachen Import, auch gleich die passende .rsf-Datei mit abgelegt. 
Eine Anleitung für den Import finden Sie unter folgendem <a href="https://github.com/aconitas/3CX-Monitoring/blob/main/HowToImportScripts.md">Link</a>.

Über denn lokal installieren **RiverSuite Agenten für Linux** können alle Zugangsdaten und Parameter direkt aus dem System, sowie ohne weitere Einstellungen automatisiert in die Checks übergeben werden. Es sind keine weiteren Anpassungen notwendig.

Diese Lösung eignet sich ideal für das automatisierte Deployment mehrerer Systeme über die **Checkpaketveraltung** in **RiverSuite**. Hierzu muss lediglich der **RiverSuite Agent für Linux** verteilt werden. Alle zugewiesenen Checks werden dann komplett automatisiert und ohne weitere Anpassung für alle inventarisierten 3CX Serversysteme verteilt.
Eine entsprechende Anleitung finden Sie <a href="https://github.com/aconitas/3CX-Monitoring/blob/main/Scripts%20(use%20with%20local%20Linux%20Monitoring%20Agent)/Checkpaketverwaltung.md">hier</a>.

# Voraussetzungen 
- Linux Debian OS
- Installlation 3CX Phone System
- Installation **RiverSuite Agent für Linux** (Die Skipte sind für diesen Agenten optimiert)

# Wichtige Information
**Als Basis für alle Checks muss zwingend der "001 - Auth Service Check" als erster Check eingerichtet werden.** Auf der Authentifizierung dieses Checks bauen alle weiteren Checks auf. Es müssen keine weiteren Parameter hinterlegt oder angepasst werden.
