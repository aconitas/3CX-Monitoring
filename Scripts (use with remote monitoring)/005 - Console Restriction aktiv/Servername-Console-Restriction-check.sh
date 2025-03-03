##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 1.0 - Remote Monitoring - Console Restriction - 2025-03-03 - Kevin Pascher
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
#### Curl-Anfrage zum Abrufen der Console Restrictions

RESULT=$(curl -s "$SERVERURL/xapi/v1/ConsoleRestrictions" -H "${HEADER}")

########################################################

#### Überprüfung der API-Antwort und Auswertung
if [[ $(echo "$RESULT" | grep -o '"AccessRestricted":true') ]]; then
  echo "Console Restriction ist aktiv"
  exit 0
else
  echo "Console Restriction ist NICHT aktiv"
  exit 2
fi
