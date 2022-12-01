# 3CX Trunks online
Dieser Check prüft ob alle angelegten Trunks registriert sind.

Output Beispiel:
![Output Beispiel](../_images/image-20221128212953-12.png)

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
RESULT=$(curl --request GET --cookie /tmp/3cxcookie --cookie-jar /tmp/3cxcookie -s localhost:${HTTP_PORT}/api/TrunkList)

########################################################
#### Auswertung
if [[ $RESULT =~ 'IsRegistered":false' ]]; then
  echo Eine oder mehrere Trunks sind NICHT registriert
  exit 2
else
  echo Alle Trunks sind registriert
  exit 0
fi
```