##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 1.0 · 2022-12-15
#
##########################################################################

########################################################
#### Import WebServerPort in Variable
HTTP_PORT=$(cat /tmp/3cx.port)

########################################################
#### Abruf Werte aus 3CX Web Console
RESULT=$(curl --request GET --cookie /tmp/3cxcookie --cookie-jar /tmp/3cxcookie -s localhost:${HTTP_PORT}/api/BackupAndRestoreList)

########################################################
#### Auswertung
if [[ $RESULT =~ '"IsEncrypted":false' ]]; then
  echo Es sind UNVERSCHLUESSELTE Backups vorhanden
  exit 2
elif [[ $RESULT =~ '"IsEncrypted":true' ]]; then
  echo Alle Backups sind verschluesselt
  exit 0
else
  echo Es liegt ein Fehler in der Konfiguration des Checks vor oder der Server ist nicht erreichbar
  exit 1
fi
