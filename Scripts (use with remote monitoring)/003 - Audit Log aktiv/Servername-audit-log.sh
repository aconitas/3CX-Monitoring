##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 1.0 - Remote Monitoring - Audit Log aktiv - 2025-03-03 - Kevin Pascher
#
##########################################################################

########################################################
#### Definition der Variablen


SERVERURL="$serverurl"

# Extrahiere einen sicheren Dateinamen aus SERVERURL
SERVERNAME=$(echo "$SERVERURL" | sed 's|https\?://||g' | sed 's|/.*||')

# Token-Extraktion und Header-Vorbereitung
TOKEN_FILE=$(cat /tmp/${SERVERNAME}.token)
HEADER="Authorization: Bearer ${TOKEN_FILE}"

########################################################
#### Abfrage der Werte

RESULT=$(curl -s "${SERVERURL}/xapi/v1/SystemStatus" -H "${HEADER}")

if [[ $RESULT =~ '"IsAuditLogEnabled":true' ]]; then
  echo AuditLog aktiv
  exit 0
elif [[ $RESULT =~ '"IsAuditLogEnabled":false' ]]; then
  echo AuditLog NICHT aktiv
  exit 2
else
  echo Fehler oder Server nicht erreichbar
  exit 1
fi
