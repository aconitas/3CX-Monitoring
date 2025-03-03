##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 1.0 - Remote Monitoring - Trunk Check - 2025-03-03 - Kevin Pascher
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
#### Curl-Anfrage zum Abrufen des Systemstatus

RESULT=$(curl -s "$SERVERURL/xapi/v1/SystemStatus" -H "${HEADER}")

########################################################
#### Überprüfung der API-Antwort und Auswertung
# Extrahiere die Anzahl der registrierten Trunks
trunks_registered=$(echo "$RESULT" | grep -oP '(?<="TrunksRegistered":)\s*\K[^,]*' | tr -d ' ')

# Extrahiere die Gesamtanzahl der Trunks
total_trunks=$(echo "$RESULT" | grep -oP '(?<="TrunksTotal":)\s*\K[^,]*' | tr -d ' ')

#echo "trunks_registered=$trunks_registered total_trunks=$total_trunks"

if [ -n "$trunks_registered" ] && [ -n "$total_trunks" ]; then
  if [ "$trunks_registered" -eq "$total_trunks" ]; then
    echo "Alle $total_trunks Trunks sind online"
    exit 0
  else
    offline_trunks=$((total_trunks - trunks_registered))
    echo "Trunks total: $total_trunks"
    echo "Anzahl der nicht registrierten Trunks: $offline_trunks"
    echo "Anzahl der registrierten Trunks: $trunks_registered"
    exit 1
  fi
else
  echo "Server ist nicht erreichbar"
  exit 1
fi
