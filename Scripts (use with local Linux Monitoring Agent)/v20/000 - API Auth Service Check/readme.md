
# 3CX API Auth Service Check
Dieser Check generiert mittels 3CX API einen Auth-Token, welcher für alle weiteren Checks genutzt werden kann.
Der API Key sowie die Client ID wird als Parameter in der Riversuit angegeben. 
Weitere benötigte Daten für den Webserver werden über den installierten Agenten vom Skript automatisch aus der 3CX Datenbank bezogen.

Die 3CX Konfiguration API steht mit einer Enterprise Lizenz bereit. Die Client-ID kann in der 3CX unter Integrationen -> API hinzugefügt werden. Wichtig: die Rolle muss Systemeigentümer sein! 
