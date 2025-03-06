##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 1.0 - Remote Monitoring - Notrufnummern Check - 2025-03-06 - Kevin Pascher
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
#### Curl-Anfrage zum Abrufen der Notrufnummern

RESULT=$(curl -s "$SERVERURL/xapi/v1/OutboundRules/Pbx.GetEmergencyOutboundRules()" -H "${HEADER}")


########################################################
####
# Prüfen, ob die Variable RESULT leer ist
if [[ -z "$RESULT" ]]; then
    echo "Keine Daten verfügbar."
    exit 1
fi

# Prüfen, ob "value" leer ist
if echo "$RESULT" | grep -q '"value":\s*\[\]'; then
    echo "Notrufnummern NICHT konfiguriert!"
    exit 1
else
    echo "Notrufnummern konfiguriert!"
    exit 0
fi
