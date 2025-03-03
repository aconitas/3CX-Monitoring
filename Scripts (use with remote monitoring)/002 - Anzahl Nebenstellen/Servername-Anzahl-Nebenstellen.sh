##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 1.0 - Remote Monitoring - Anzahl der Nebenstellen auslesen - 2025-03-03 - Kevin Pascher
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

# Curl-Anfrage zum Abrufen des Systemstatus
RESULT=$(curl -s "${SERVERURL}/xapi/v1/SystemStatus" -H "${HEADER}")

# Extrahiere die Anzahl der gesamten Nebenstellen
total_extensions=$(echo "$RESULT" | awk -F'"ExtensionsTotal":' '{print $2}' | awk -F',' '{print $1}' | tr -d ' ')

# Extrahiere die Anzahl der angemeldeten Nebenstellen
registered_extensions=$(echo "$RESULT" | awk -F'"ExtensionsRegistered":' '{print $2}' | awk -F',' '{print $1}' | tr -d ' ')

echo "Anzahl der Nebenstellen: $total_extensions"
echo "Angemeldete Nebenstellen: $registered_extensions"
exit 0
