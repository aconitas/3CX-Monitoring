##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 3CX V20 1.0 · 2024-03-01
#
##########################################################################

########################################################
#### Import WebServerPort in Variable
HTTP_PORT=$(cat /tmp/3cx.port)

########################################################
#### Token-Extraktion und Header-Vorbereitung
TOKEN=$(</tmp/3cx.token)
HEADER="Authorization: Bearer ${TOKEN}"

########################################################
#### Curl-Anfrage zum Abrufen des Systemstatus
RESULT=$(curl -s "localhost:${HTTP_PORT}/xapi/v1/SystemStatus" -H "${HEADER}")

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
