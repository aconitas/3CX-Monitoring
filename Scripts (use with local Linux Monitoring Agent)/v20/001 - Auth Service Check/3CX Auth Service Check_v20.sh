##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 3CX V20 1.1 · 2024-06-13 KP
#
##########################################################################

########################################################
#### Exit-Status ungleich Null
set -e

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
RESULT=$(curl -s -X POST localhost:${HTTP_PORT}/webclient/api/Login/GetAccessToken -H "Content-Type: application/json" -d '{"username": "'$username'", "password": "'$Password'"}')

########################################################
#### Prüfung der Ausgaben für Troubleshooting
#echo $Username
#echo $Password
#echo $HTTP_PORT
#echo $RESULT

echo $RESULT > /tmp/3cx.token
if [[ $RESULT == *AuthSuccess* ]]; then
  echo "Anmeldung erfolgreich"
  if [[ $RESULT == *access_token* ]]; then
    RESULT=$(mawk -F'access_token|refresh_token' '{print $2}' /tmp/3cx.token)
    size=${#RESULT}
    RESULT=${RESULT:3:size-6}
    echo $RESULT > /tmp/3cx.token
    #echo "Token angefordert"
    exit 0
  else
    rm /tmp/3cx.token
    echo "Token Anforderung fehlgeschlagen"
    exit 1
  fi
  exit 0
else
  echo "Anmeldung fehlgeschlagen"
  exit 1
fi
