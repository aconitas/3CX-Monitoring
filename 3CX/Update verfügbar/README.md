# 3CX Update verfügbar
Dieser Check prüft ob die aktuelle Version der 3CX verwendet wird oder ein Update zur Verfügung steht.

Output Beispiel:
![Output Beispiel](../_images/image-20221128213049-13.png)

Code:
```bash
#   Herausgeber: aconitas® GmbH - Bäumenheimer Str. 5 - 86690 Mertingen
#   Website: https://www.aconitas.com
#   Telefon: +49 (906) 126725-0
#   E-Mail: info@aconitas.com
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
```