##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 1.0 - Remote Monitoring - Lizenzkey + Edition - 2025-03-03 - Kevin Pascher
#
##########################################################################

########################################################
#### Definition der Variablen


SERVERURL="HIER URL Eintragen: https://XXXXXX"

# Extrahiere einen sicheren Dateinamen aus SERVERURL
SERVERNAME=$(echo "$SERVERURL" | sed 's|https\?://||g' | sed 's|/.*||')

# Token-Extraktion und Header-Vorbereitung
TOKEN_FILE=$(cat /tmp/${SERVERNAME}.token)
HEADER="Authorization: Bearer ${TOKEN_FILE}"

########################################################
#### Curl-Anfrage zum Abrufen des Systemstatus
RESULT=$(curl -s "$SERVERURL/xapi/v1/SystemStatus" -H "${HEADER}")

########################################################
#### Extrahiere den Lizenzschlüssel
license_key=$(echo "$RESULT" | awk -F'"LicenseKey":"' '{print $2}' | awk -F'"' '{print $1}' | tr -d ' ')

########################################################
#### Extrahiere die Edition
edition=$(echo "$RESULT" | awk -F'"ProductCode":"' '{print $2}' | awk -F'"' '{print $1}' | tr -d ' ')

########################################################
#### Extrahiere die maximale gleichzeitige Anrufe
max_sim_calls=$(echo "$RESULT" | awk -F'"MaxSimCalls":' '{print $2}' | awk -F',' '{print $1}' | tr -d ' ')

########################################################
#### Überprüfe, ob der Lizenzschlüssel, die Edition und maximale gleichzeitige Anrufe vorhanden sind
if [ -n "$license_key" ] && [ -n "$edition" ] && [ -n "$max_sim_calls" ]; then
  echo "Lizenzschluessel: $license_key  ; "
  echo "Edition: $edition  ; "
  echo "Maximale gleichzeitige Anrufe: $max_sim_calls  ; "
  exit 0
else
  echo "Server ist nicht erreichbar ;"
  exit 1
fi
