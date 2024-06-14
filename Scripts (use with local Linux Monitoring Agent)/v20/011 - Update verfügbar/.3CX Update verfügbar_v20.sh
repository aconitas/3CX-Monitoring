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
#### Curl-Anfrage zum Abrufen der Update-Informationen
RESULT=$(curl -s "localhost:${HTTP_PORT}/xapi/v1/UpdatesStats" -H "${HEADER}")

########################################################
#### Auswertung
if [[ "$RESULT" == *"no connection"* ]]; then
  echo "Keine Verbindung zum Server"
  exit 1
fi

updates_count=$(jq '.TcxUpdate | length' <<< "$RESULT")

if [[ "$updates_count" -gt 0 ]]; then
  echo "Update verfügbar"
  exit 2
else
  echo "System ist aktuell"
  exit 0
fi
