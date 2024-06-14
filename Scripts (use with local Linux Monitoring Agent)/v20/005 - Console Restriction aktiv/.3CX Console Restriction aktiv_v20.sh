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
HTTP_PORT=$(< /tmp/3cx.port)

########################################################
#### Token-Extraktion und Header-Vorbereitung
TOKEN=$(< /tmp/3cx.token)
HEADER="Authorization: Bearer ${TOKEN}"

########################################################
#### Curl-Anfrage zum Abrufen der Console Restrictions

RESULT=$(curl -s "localhost:${HTTP_PORT}/xapi/v1/ConsoleRestrictions" -H "${HEADER}")

########################################################

#### Überprüfung der API-Antwort und Auswertung
if [[ $(echo "$RESULT" | grep -o '"AccessRestricted":true') ]]; then
  echo "Console Restriction ist aktiv ; "
  exit 0
else
  echo "Console Restriction ist NICHT aktiv ; "
  exit 2
fi
