##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 1.0 - Remote Monitoring - SBCReg Check - 2025-03-03 - Kevin Pascher
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
#### Curl-Anfrage zum Abrufen der SBCs

JSON_DATA=$(curl -s "$SERVERURL/xapi/v1/Sbcs?" -H "${HEADER}")

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
