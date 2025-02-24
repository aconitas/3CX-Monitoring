##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 3CX V20 1.1 · 2025-01-20 KP
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
#### Generierung Access Token

# Define the necessary variables
CLIENT_ID="$clientid"
CLIENT_SECRET="$clientsecret"

# Make the POST request
response=$(curl -s -X POST localhost:${HTTP_PORT}/connect/token \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "client_id=$CLIENT_ID" \
  -d "client_secret=$CLIENT_SECRET" \
  -d "grant_type=client_credentials")

# Print the response (JSON response with token)
echo "$response" | grep -o '"access_token":"[^"]*"' | sed 's/"access_token":"//;s/"//g' > /tmp/3cx.token

########################################################
#### Prüfung der Ausgaben für Troubleshooting

if [ -s "/tmp/3cx.token" ]; then
    echo "Auth-Token generiert!"
        exit 0
else
    echo "Auth-Token FEHLER"
        exit 1
fi
