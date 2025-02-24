##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 3CX V20 2.0 · 2025-02-24 - KP
#
##########################################################################

#!/bin/bash

########################################################
#### Import WebServerPort in Variable
HTTP_PORT=$(cat /tmp/3cx.port)

########################################################
#### Token-Extraktion und Header-Vorbereitung
TOKEN=$(</tmp/3cx.token)
HEADER="Authorization: Bearer ${TOKEN}"


########################################################
####Curl-Anfrage zum Abrufen der SBCs

JSON_DATA=$(curl -s "localhost:${HTTP_PORT}/xapi/v1/Sbcs?" -H "${HEADER}")



# Anzahl der SBCs insgesamt
TOTAL=$(echo "$JSON_DATA" | grep -o '"HasConnection"' | wc -l)

# Anzahl der verbundenen SBCs
CONNECTED=$(echo "$JSON_DATA" | grep -o '"HasConnection":true' | wc -l)

# Falls keine SBCs vorhanden sind, Skript beenden
if [ "$CONNECTED" -eq 0 ]; then
    echo "Kein SBC vorhanden"
    exit 0
fi

# Prüfen, ob alle SBCs online sind
if [ "$CONNECTED" -eq "$TOTAL" ]; then
    echo "Alle SBCs sind online"
    exit 0
fi

# Falls mindestens ein SBC offline ist, detaillierte Ausgabe:
echo "Mindestens ein SBC ist offline!"
echo "Verbunden: $CONNECTED"
echo "Offline: $((TOTAL - CONNECTED))"

# Skript mit Exit-Code 2 beenden, da mindestens ein SBC offline ist
exit 2
