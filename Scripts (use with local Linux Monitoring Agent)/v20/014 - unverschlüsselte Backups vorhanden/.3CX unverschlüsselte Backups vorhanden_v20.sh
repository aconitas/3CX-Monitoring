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
# Curl-Anfrage zum Abrufen der Backup-Einstellungen
RESULT=$(curl -s "localhost:${HTTP_PORT}/xapi/v1/Backups/Pbx.GetBackupSettings()" -H "${HEADER}")

# Auswertung der API-Antwort
if echo "$RESULT" | grep -q '"EncryptBackup":false'; then
  echo "Unverschluesseltes Backup ist vorhanden"
  exit 2
elif echo "$RESULT" | grep -q '"EncryptBackup":true'; then
  echo "Verschluesseltes Backup ist vorhanden"
  exit 0
else
  echo "Fehler: Keine gueltige Antwort vom Server erhalten oder der Server ist nicht erreichbar.  ; "
  exit 1
fi
