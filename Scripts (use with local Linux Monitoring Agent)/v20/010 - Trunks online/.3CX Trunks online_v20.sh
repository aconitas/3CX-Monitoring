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
#### Curl-Anfrage zum Abrufen des Systemstatus
RESULT=$(curl -s "localhost:${HTTP_PORT}/xapi/v1/SystemStatus" -H "${HEADER}")

########################################################
#### Überprüfung der API-Antwort und Auswertung
# Extrahiere die Anzahl der registrierten Trunks
trunks_registered=$(echo "$RESULT" | grep -oP '(?<="TrunksRegistered":)\s*\K[^,]*' | tr -d ' ')

# Extrahiere die Gesamtanzahl der Trunks
total_trunks=$(echo "$RESULT" | grep -oP '(?<="TrunksTotal":)\s*\K[^,]*' | tr -d ' ')

echo "trunks_registered=$trunks_registered total_trunks=$total_trunks"

if [ -n "$trunks_registered" ] && [ -n "$total_trunks" ]; then
  if [ "$trunks_registered" -eq "$total_trunks" ]; then
    echo "Alle Trunks sind online"
    exit 0
  else
    offline_trunks=$((total_trunks - trunks_registered))
    echo "Anzahl der registrierten Trunks: $trunks_registered"
    echo "Anzahl der nicht registrierten Trunks: $offline_trunks"
    exit 2
  fi
else
  echo "Server ist nicht erreichbar"
  exit 1
fi
