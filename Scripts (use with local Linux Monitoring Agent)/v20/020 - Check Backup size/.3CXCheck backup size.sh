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
#### Curl-Anfrage zum Abrufen der Backup-Groessen

BackupLines=$(curl -s "localhost:${HTTP_PORT}/xapi/v1/Backups" -H "${HEADER}")

########################################################
#### Berechnung der gesamten Backup-Summe
SumSize=0
BackupCounter=0
BackupMaxSize=0

# Durchlaufen der Zeilen mit grep und Berechnung
while read -r line; do
  size=$(echo "$line" | grep -o '"Size":[0-9]*' | grep -o '[0-9]*')
  if [ -n "$size" ]; then
    BackupSize=$((size))
    ((SumSize += BackupSize))
    ((BackupCounter++))

    if [ $BackupSize -gt $BackupMaxSize ]; then
      BackupMaxSize=$BackupSize
    fi
  fi
done <<< "$(echo "$BackupLines" | tr -d '\n' | grep -o '{[^}]*"Size":[0-9]*[^}]*}')"

((SumSize /= 1048576))
((BackupMaxSize /= 1048576))

########################################################
#### Auswertung und Ausgabe mit ersetzten Umlauten
if [ $BackupCounter -eq 0 ]; then
  echo "Keine Backups gefunden."
  exit 0
elif [ $SumSize -gt 0 ]; then
  echo "Anzahl der Backups: $BackupCounter"
  echo "gesamt: $SumSize MB"
  echo "max. File: $BackupMaxSize MB"
  exit 0
else
  echo "Fehler oder Server nicht erreichbar."
  exit 1
fi
