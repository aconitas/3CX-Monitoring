##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 1.0 - Remote Monitoring - SBCVersion Check - 2025-03-03 - Kevin Pascher
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
