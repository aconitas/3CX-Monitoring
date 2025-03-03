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
#### Abruf Werte aus 3CX Web Console

RESULT=$(curl -s "$SERVERURL/xapi/v1/CrmIntegration" -H "${HEADER}")

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
