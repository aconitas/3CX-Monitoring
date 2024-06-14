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
#### Token-Extraktion und Header-Vorbereitung
TOKEN=$(</tmp/3cx.token)
HEADER="Authorization: Bearer ${TOKEN}"

########################################################
#### Curl-Anfrage zum Abrufen der Auto-Backup-Einstellungen
RESULT=$(curl -s "localhost:${HTTP_PORT}/xapi/v1/Backups/Pbx.GetBackupSettings()" -H "${HEADER}")

########################################################
#### Überprüfung der API-Antwort und Auswertung
auto_backup_active=$(echo "$RESULT" | grep -o '"ScheduleEnabled":[^,}]*' | grep -oE '(true|false)')

if [ "$auto_backup_active" = "true" ]; then
  echo "Auto-Backup ist aktiv. ; "
  exit 0
elif [ "$auto_backup_active" = "false" ]; then
  echo "Auto-Backup ist nicht aktiv. ; "
  exit 2
else
  echo "Keine Verbindung zum Server. ; "
  exit 1
fi
