#   Herausgeber: 
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 1.0



########################################################
#### Import WebServerPort in Variable
HTTP_PORT=$(cat /tmp/3cx.port)
#echo $HTTP_PORT

########################################################
#### Abruf Werte aus 3CX Web Console
RESULT=$(curl --request GET --cookie /tmp/3cxcookie --cookie-jar /tmp/3cxcookie -s localhost:${HTTP_PORT}/api/UpdateChecker/GetFromParams)

########################################################
#### Auswertung
if [[ $RESULT =~ '{"tcxUpdate":"[]","perPage":"[]"}' ]]; then
  echo Ihr System verwendet die aktuellste Version
  exit 0
else
  echo Ausstehende Updates erkannt
  exit 2
fi
