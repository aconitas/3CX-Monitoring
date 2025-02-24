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
#### Curl-Anfrage zum Abrufen des Systemstatus

JSON_DATA=$(curl -s "localhost:${HTTP_PORT}/xapi/v1/Trunks?" -H "${HEADER}")


########################################################
#### Überprüfung der API-Antwort und Auswertung
# Extrahiere die Anzahl der registrierten Trunks

# Anzahl der Trunks insgesamt
TOTAL=$(echo "$JSON_DATA" | grep -o '"IsOnline"' | wc -l)

# Anzahl der online Trunks
ONLINE=$(echo "$JSON_DATA" | grep -o '"IsOnline":true' | wc -l)

# Prüfen, ob alle Trunks online sind
if [ "$ONLINE" -eq "$TOTAL" ]; then
    echo "Alle SIP Trunks (Anzahl: $TOTAL) sind online "
    exit 0
fi

# Falls mindestens ein Trunk offline ist, detaillierte Ausgabe:
echo "Mindestens ein Trunk ist offline!"
echo "Total: $TOTAL"
echo "Online: $ONLINE"
echo "Offline: $((TOTAL - ONLINE))"
exit 1
