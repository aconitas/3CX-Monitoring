
##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 1.0 - Remote Monitoring - API Auth Skript· 2025-03-03 - Kevin Pascher
#
##########################################################################


########################################################
#### Definition der Variablen

CLIENT_ID="$clientid"
CLIENT_SECRET="$clientsecret"
SERVERURL="$serverurl"

# Extrahiere einen sicheren Dateinamen aus SERVERURL
SERVERNAME=$(echo "$SERVERURL" | sed 's|https\?://||g' | sed 's|/.*||')
TOKEN_FILE="/tmp/${SERVERNAME}.token"

########################################################
#### Generierung Access Token

# Make the POST request
response=$(curl -s -X POST ${SERVERURL}/connect/token \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "client_id=$CLIENT_ID" \
  -d "client_secret=$CLIENT_SECRET" \
  -d "grant_type=client_credentials")

# Print the response (JSON response with token)
echo "$response" | grep -o '"access_token":"[^"]*"' | sed 's/"access_token":"//;s/"//g' > "$TOKEN_FILE"

########################################################
#### Statusausgaben

if [ -s "$TOKEN_FILE" ]; then
    echo "Auth-Token generiert!"
        exit 0
else
    echo "Auth-Token FEHLER"
        exit 1
fi
