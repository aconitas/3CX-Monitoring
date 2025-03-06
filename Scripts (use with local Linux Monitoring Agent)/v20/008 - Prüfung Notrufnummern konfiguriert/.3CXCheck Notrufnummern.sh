##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 3CX V20 1.0 · 2025-03-06 - Kevin Pascher - Notrufnummerncheck
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
#### Curl-Anfrage zum Abrufen der Userkonten

RESULT=$(curl -s "localhost:${HTTP_PORT}/xapi/v1/OutboundRules/Pbx.GetEmergencyOutboundRules()" -H "${HEADER}")

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
