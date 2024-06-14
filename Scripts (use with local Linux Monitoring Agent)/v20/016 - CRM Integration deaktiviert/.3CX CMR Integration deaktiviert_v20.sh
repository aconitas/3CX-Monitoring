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
#### Import WebServerPort und Token
HTTP_PORT=$(cat /tmp/3cx.port)
TOKEN=$(cat /tmp/3cx.token)

########################################################
#### Header-Vorbereitung
HEADER="Authorization: Bearer ${TOKEN}"

########################################################
#### Abruf Werte aus 3CX Web Console
RESULT=$(curl --request GET --cookie /tmp/3cxcookie --cookie-jar /tmp/3cxcookie -s "localhost:${HTTP_PORT}/xapi/v1/CrmIntegration" -H "${HEADER}")

########################################################
#### Auswertung
crm_name=$(echo "$RESULT" | grep -oP '(?<="Name":")[^"]+')

if [[ $crm_name =~ 'CRM.NoneCrmSelected' ]]; then
  echo "Keine CRM-Integration vorhanden"
  exit 0
elif [[ -n "$crm_name" ]]; then
  echo "CRM-Integration vorhanden: $crm_name"
  exit 2
else
  echo Fehler im Skript oder Server nicht erreichbar
  exit 1
fi
