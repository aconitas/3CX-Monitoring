##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 1.0 - Remote Monitoring - Backupverschlüsselung - 2025-03-03 - Kevin Pascher
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
####Curl-Anfrage zum Abrufen der Backup-Einstellungen


RESULT=$(curl -s "${SERVERURL}/xapi/v1/Backups/Pbx.GetBackupSettings()" -H "${HEADER}")

# Auswertung der API-Antwort
if echo "$RESULT" | grep -q '"EncryptBackup":false'; then
  echo "Unverschluesseltes Backup ist vorhanden"
  exit 2
elif echo "$RESULT" | grep -q '"EncryptBackup":true'; then
  echo "alle Backups sind verschlüsselt"
  exit 0
else
  echo "Fehler: Keine gueltige Antwort vom Server erhalten oder der Server ist nicht erreichbar.  ; "
  exit 1
fi
