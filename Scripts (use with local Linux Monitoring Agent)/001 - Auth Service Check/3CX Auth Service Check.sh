##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 1.2 · 2023-03-27
#
##########################################################################

########################################################
#### Import Zugangsdaten aus 3CX DB
Password=$(sudo -u postgres psql -d database_single -c "SELECT * FROM parameter where name='WEBSERVERPASS'" | grep WEBSERVERPASS | tr -s ' ' | cut -d ' ' -f 10)
Username=$(sudo -u postgres psql -d database_single -c "SELECT * FROM parameter where name='WEBSERVERUSER'" | grep WEBSERVERUSER | tr -s ' ' | cut -d ' ' -f 10)

########################################################
#### Import WebServerPort aus 3CX DB
WEB_SERVER_PORT=$(sudo -u postgres psql -d database_single -c "SELECT * FROM parameter where name='WEB_ROOT_LOCAL'" | grep WEB_ROOT_LOCAL | tr -s ' ' | cut -d ' ' -f7)
WEB_SERVER_PORT=${WEB_SERVER_PORT:7} 

########################################################
#### Export WebServerPort in ConfFile auf 3CX Server
if [[ $WEB_SERVER_PORT =~ ':' ]]; then
 echo $WEB_SERVER_PORT | sed "s|.*:\(.*\)/.*|\\1|" > /tmp/3cx.port
else
 echo 80 > /tmp/3cx.port
fi

########################################################
#### Import WebServerPort in Variable
HTTP_PORT=$(cat /tmp/3cx.port)

########################################################
#### Authentifizierung an 3CX Web Console
RESULT=$(curl -s --request POST --cookie /tmp/3cxcookie --cookie-jar /tmp/3cxcookie --data "{'username':'$Username','password':'$Password'}" --header "Content-Type: application/json" --output - localhost:${HTTP_PORT}/api/login)

#echo $RESULT

if [[ $RESULT =~ 'AuthSuccess' ]]; then
  RESULTTOKEN=$(curl --request GET --cookie /tmp/3cxcookie --cookie-jar /tmp/3cxcookie -s localhost:${HTTP_PORT}/api/Token)
  if [[ $RESULTTOKEN =~ '"access_token":' ]]; then
    echo $RESULTTOKEN | egrep -o '"access_token":"([^\s].*)","' | sed -nr 's/"access_token":"([^\s].*)","/\1/p' > /tmp/3cx.token
  else
    rm /tmp/3cx.token
    echo Token Anforderung fehlgeschlagen.
  fi
  echo Anmeldung erfolgreich
  exit 0
else
  echo Anmeldung fehlgeschlagen
  exit 1
fi
