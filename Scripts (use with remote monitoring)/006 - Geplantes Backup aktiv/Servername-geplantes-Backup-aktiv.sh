##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 1.0 - Remote Monitoring - geplantes Backup - 2025-03-03 - Kevin Pascher
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
####Curl-Anfrage zum Abrufen der Auto-Backup-Einstellungen

RESULT=$(curl -s "$SERVERURL/xapi/v1/Backups/Pbx.GetBackupSettings()" -H "${HEADER}")

########################################################
#### Überprüfung der API-Antwort und Auswertung
auto_backup_active=$(echo "$RESULT" | grep -o '"ScheduleEnabled":[^,}]*' | grep -oE '(true|false)')

if [ "$auto_backup_active" = "true" ]; then
  echo "Auto-Backup ist aktiv "
  exit 0
elif [ "$auto_backup_active" = "false" ]; then
  echo "Auto-Backup ist nicht aktiv"
  exit 2
else
  echo "Keine Verbindung zum Server. ; "
  exit 1
fi
