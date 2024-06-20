##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 3CX V20 1.0 · 2024-03-01
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
#### Abruf Werte aus 3CX Web Console
RESPONSE=$(curl --request GET --cookie /tmp/3cxcookie --cookie-jar /tmp/3cxcookie -s "localhost:${HTTP_PORT}/xapi/v1/E164Settings" -H "${HEADER}")

########################################################
#### Überprüfen, ob E164-Verarbeitung aktiviert ist
ENABLED=$(echo "$RESPONSE" | grep -oP '(?<="Enabled":)\s*\K[^,]*' | tr -d '"')

########################################################
#### Auswertung
if [[ "$ENABLED" == "true" ]]; then
  echo "E164-Verarbeitung ist aktiviert"
  exit 2
else
  echo "E164-Verarbeitung ist nicht aktiviert"
  exit 0
fi
