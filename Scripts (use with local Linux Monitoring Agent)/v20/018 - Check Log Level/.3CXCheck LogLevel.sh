##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 3CX V20 1.0 · 2024-03-01
#
##########################################################################

#!/bin/bash

########################################################
#### Import WebServerPort in Variable
HTTP_PORT=$(cat /tmp/3cx.port)

########################################################
#### Token-Extraktion und Header-Vorbereitung
TOKEN=$(cat /tmp/3cx.token)
HEADER="Authorization: Bearer ${TOKEN}"

########################################################
#### Curl-Anfrage zum Abrufen der Logging-Einstellungen
LoggingSettingsResponse=$(curl --request GET --cookie /tmp/3cxcookie --cookie-jar /tmp/3cxcookie -s "localhost:${HTTP_PORT}/xapi/v1/LoggingSettings" -H "${HEADER}")

# Überprüfen, ob die Antwort leer ist oder das erwartete "odata.context"-Feld fehlt
if [ -z "$LoggingSettingsResponse" ] || ! echo "$LoggingSettingsResponse" | grep -q "odata\.context"; then
  echo "Fehler beim Abrufen der Logging-Einstellungen. Die Antwort war leer oder es fehlt das erwartete odata.context Feld. Überprüfen Sie die Konfiguration oder die Erreichbarkeit des Servers."
  exit 1
fi

# Funktion zum Extrahieren des Werts aus dem JSON-String mit grep
extract_value() {
  local key="$1"
  echo "$LoggingSettingsResponse" | grep -o "\"$key\":[^,}]*" | cut -d ":" -f 2- | tr -d '" ,'
}

# Versuchen Sie, die Werte abzurufen
LogLevel=$(extract_value "LoggingLevel")
KeepDay=$(extract_value "KeepLogsDays")
KeepStatus=$(extract_value "KeepLogs")

# Überprüfen, ob die abgerufenen Werte leer oder null sind
if [[ -z $LogLevel ]] || [[ -z $KeepDay ]] || [[ -z $KeepStatus ]]; then
  echo "Fehler beim Parsen der Logging-Einstellungen. Überprüfen Sie die Konfiguration oder die Erreichbarkeit des Servers."
  exit 1
fi

# Hier können Sie weitere Verarbeitungsschritte hinzufügen, je nach Ihren Anforderungen.

# Beispiel: Log-Meldung basierend auf LogLevel
if [[ "$LogLevel" == "0" ]]; then
  echo "Das Logging der 3CX ist nicht aktiv"
  exit 1
elif [[ "$LogLevel" == "1" ]]; then
  echo "Loglevel ist auf Gering eingestellt"
  exit 2
elif [[ "$LogLevel" == "2" ]]; then
  echo "Loglevel ist auf Mittel eingestellt"
elif [[ "$LogLevel" == "3" ]]; then
  echo "ACHTUNG: Loglevel ist auf Verbose Mode eingestellt"
  exit 1
fi

# Beispiel: Weitere Verarbeitungsschritte basierend auf KeepStatus und KeepDay
if [[ "$KeepStatus" == "true" ]]; then
  echo "Die Aufbewahrungspolitik ist aktiv mit $KeepDay Tagen"
else
  echo "Die Aufbewahrungspolitik ist INAKTIV"
  exit 2
fi
