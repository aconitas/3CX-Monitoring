##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 3CX V20 1.0 · 2024-03-01
#
##########################################################################

########################################################
#### Import WebServerPort in Variable
HTTP_PORT=$(cat /tmp/3cx.port)

# Token-Extraktion und Header-Vorbereitung
TOKEN=$(</tmp/3cx.token)
HEADER="Authorization: Bearer ${TOKEN}"

# Curl-Anfrage zum Abrufen des Systemstatus
RESULT=$(curl -s "localhost:${HTTP_PORT}/xapi/v1/SystemStatus" -H "${HEADER}")

# Extrahiere die Anzahl der gesamten Nebenstellen
total_extensions=$(echo "$RESULT" | awk -F'"ExtensionsTotal":' '{print $2}' | awk -F',' '{print $1}' | tr -d ' ')

# Extrahiere die Anzahl der angemeldeten Nebenstellen
registered_extensions=$(echo "$RESULT" | awk -F'"ExtensionsRegistered":' '{print $2}' | awk -F',' '{print $1}' | tr -d ' ')

echo "Gesamte Nebenstellen: $total_extensions, Angemeldete Nebenstellen: $registered_extensions   ; "

# Überprüfe, ob alle Nebenstellen abgemeldet sind
#if [ "$registered_extensions" -eq 0 ]; then
#  exit 2
#fi

exit 0
