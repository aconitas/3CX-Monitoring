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
RESULT=$(curl --request GET --cookie /tmp/3cxcookie --cookie-jar /tmp/3cxcookie -s localhost:${HTTP_PORT}/api/ExtensionList)

########################################################
#### Auswertung
if [[ $RESULT =~ '"invalidPasswords":[0' || $RESULT =~ '"invalidPasswords":[1' || $RESULT =~ '"invalidPasswords":[2' ]]; then
  echo Eine oder mehrere Nebenstellen nutzen UNSICHERE Zugangsdaten
 exit 2
else
  echo Alle Nebenstellen nutzen sichere Zugangsdaten
  exit 0
fi
