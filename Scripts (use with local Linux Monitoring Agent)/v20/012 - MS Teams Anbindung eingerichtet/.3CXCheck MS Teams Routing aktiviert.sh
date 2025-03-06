##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 3CX V20 1.0 · 2025-03-04 - Kevin Pascher - MS Teams Direct Routing
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

RESULT=$(curl -s "localhost:${HTTP_PORT}/xapi/v1/Microsoft365TeamsIntegration?" -H "${HEADER}")

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
