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
RESULT=$(curl --request GET --cookie /tmp/3cxcookie --cookie-jar /tmp/3cxcookie -s localhost:${HTTP_PORT}/api/SystemStatus  | egrep -io '"LicenseKey":[^,]*' | cut -d ':'  -f 2 | tr -d \")
SimCalls=$(curl --request GET --cookie /tmp/3cxcookie --cookie-jar /tmp/3cxcookie -s localhost:${HTTP_PORT}/api/SystemStatus  | egrep -io '"MaxSimCalls":[^,]*' | cut -d ':'  -f 2)
Edition=$(curl --request GET --cookie /tmp/3cxcookie --cookie-jar /tmp/3cxcookie -s localhost:${HTTP_PORT}/api/SystemStatus  | egrep -io '"ProductCode":[^,]*' | cut -d ':'  -f 2 | tr -d \")

########################################################
#### Auswertung
echo $Edition $SimCalls SC
echo $RESULT