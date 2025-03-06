##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 1.0 - Remote Monitoring - MS Teams Check Check - 2025-03-06 - Kevin Pascher
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
#### Curl-Anfrage zum Abrufen der MS Teams Settings

RESULT=$(curl -s "$SERVERURL/xapi/v1/Microsoft365TeamsIntegration?" -H "${HEADER}")

########################################################
#### 

# Prüfen, ob die Variable RESULT leer ist
if [[ -z "$RESULT" ]]; then
    echo "Microsoft Teams Direct Routing ist nicht aktiviert"
    exit 0
fi

# Prüfen, ob "Enabled":true in der JSON-Antwort enthalten ist
if echo "$RESULT" | grep -q '"Enabled":true'; then
    echo "Microsoft Teams ist aktiviert."
	exit 1
else
    echo "Microsoft Teams ist nicht aktiviert."
	exit 0
fi
