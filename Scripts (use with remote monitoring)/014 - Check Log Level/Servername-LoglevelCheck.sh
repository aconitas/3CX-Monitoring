##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 1.0 - Remote Monitoring - Log Level Check - 2025-03-03 - Kevin Pascher
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
#### Abruf Werte aus 3CX Web Console

RESPONSE=$(curl -s "$SERVERURL/xapi/v1/E164Settings" -H "${HEADER}")

########################################################
#### Überprüfen, ob E164-Verarbeitung aktiviert ist
ENABLED=$(echo "$RESPONSE" | grep -oP '(?<="Enabled":)\s*\K[^,]*' | tr -d '"')

########################################################
#### Auswertung
if [[ "$ENABLED" == "true" ]]; then
  echo "E164-Verarbeitung ist aktiviert"
  exit 2
else
  echo "E164-Verarbeitung ist nicht aktiviert"
  exit 0
fi
