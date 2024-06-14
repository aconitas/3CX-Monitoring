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

########################################################
#### Auswertung
TOKEN=$(</tmp/3cx.token)
HEADER="Authorization: Bearer ${TOKEN}"
RESULT=$(curl -s "localhost:${HTTP_PORT}/xapi/v1/SystemStatus" -H "${HEADER}")

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
