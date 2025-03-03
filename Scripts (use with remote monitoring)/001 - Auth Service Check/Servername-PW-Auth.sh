##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 1.0 - Remote Monitoring - PW Auth Skript· 2025-03-03 - Kevin Pascher
#
##########################################################################


########################################################
#### Definition der Variablen

CLIENT_ID="$username"
CLIENT_SECRET="$password"
SERVERURL="$serverurl"

# Extrahiere einen sicheren Dateinamen aus SERVERURL
SERVERNAME=$(echo "$SERVERURL" | sed 's|https\?://||g' | sed 's|/.*||')
TOKEN_FILE="/tmp/${SERVERNAME}.token"


########################################################
#### Authentifizierung an 3CX Web Console
RESULT=$(curl -s -X POST ${SERVERURL}/webclient/api/Login/GetAccessToken -H "Content-Type: application/json" -d '{"username": "'$CLIENT_ID'", "password": "'$CLIENT_SECRET'"}')

########################################################
#### Statusausgaben

echo $RESULT > $TOKEN_FILE
if [[ $RESULT == *AuthSuccess* ]]; then
  echo "Anmeldung erfolgreich"
  if [[ $RESULT == *access_token* ]]; then
    RESULT=$(mawk -F'access_token|refresh_token' '{print $2}' $TOKEN_FILE)
    size=${#RESULT}
    RESULT=${RESULT:3:size-6}
    echo $RESULT > $TOKEN_FILE
    exit 0
  else
        echo "Token Anforderung fehlgeschlagen"
    exit 1
  fi
  exit 0
else
  echo "Anmeldung fehlgeschlagen"
  exit 1
fi
