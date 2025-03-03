##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 1.0 - Remote Monitoring - Updatecheck - 2025-03-03 - Kevin Pascher
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
#### Curl-Anfrage zum Abrufen der Update-Informationen

RESULT=$(curl -s "${SERVERNAME}/xapi/v1/GetUpdatesStats()" -H "${HEADER}")
RESULT_INST_VERSION=$(curl -s "${SERVERNAME}/xapi/v1/SystemStatus" -H "${HEADER}")


########################################################
#### Auslesen der aktuell installierten Version

VERSION=$(echo "$RESULT_INST_VERSION" | grep -o '"Version":"[^"]*"' | sed 's/"Version":"//;s/"//g')


########################################################
#### Auswertung
if [[ "$RESULT" == *"no connection"* ]]; then
  echo "Keine Verbindung zum Server"
  exit 1
fi

updates_count=$(echo "$RESULT" | grep -o '"TcxUpdate":\[[^]]*\]' | grep -o '{' | wc -l)

if [[ "$updates_count" -gt 0 ]]; then
  echo "Update verfuegbar. Installierte Version:" $VERSION
  exit 2
else
  echo "System ist aktuell. Installierte Version:" $VERSION
  exit 0
fi
