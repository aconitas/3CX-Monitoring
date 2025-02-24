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


# Anzahl der SBCs mit Versionseintrag ermitteln
TOTAL_SBC=$(echo "$JSON_DATA" | grep -o '"Version"' | wc -l)

# Falls keine SBCs vorhanden sind, Skript beenden
if [ "$TOTAL_SBC" -eq 0 ]; then
    echo "Kein SBC vorhanden"
    exit 0
fi

# Prüfen, welche Versionen vorhanden sind
if echo "$JSON_DATA" | grep -q '"Version":"16'; then
    echo "SBC in Version 16 vorhanden!" 
exit 1
elif echo "$JSON_DATA" | grep -q '"Version":"18'; then
    echo "SBC in Version 18 vorhanden!" 
exit 1
elif echo "$JSON_DATA" | grep -q '"Version":"20'; then
    echo "SBC in Version 20 vorhanden!" 
exit 0
else
    echo "Unbekannte SBC Version!"
exit 1
fi
