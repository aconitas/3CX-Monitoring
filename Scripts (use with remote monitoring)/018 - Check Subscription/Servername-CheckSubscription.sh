##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 1.0 - Remote Monitoring - Subscription Check - 2025-03-03 - Kevin Pascher
#
##########################################################################

########################################################
#### Definition der Variablen

SERVERURL="HIER URL Eintragen: https://XXXXXX"

# Extrahiere einen sicheren Dateinamen aus SERVERURL
SERVERNAME=$(echo "$SERVERURL" | sed 's|https\?://||g' | sed 's|/.*||')

# Token-Extraktion und Header-Vorbereitung
TOKEN_FILE=$(cat /tmp/${SERVERNAME}.token)
HEADER="Authorization: Bearer ${TOKEN_FILE}"

########################################################
#### Curl-Anfrage zum Abrufen des Systemstatus
RESULT=$(curl -s "$SERVERURL/xapi/v1/SystemStatus" -H "${HEADER}")

########################################################
#### Überprüfung der API-Antwort und Auswertung
# Extrahiere die Lizenzinformationen
license_active=$(echo "$RESULT" | awk -F'"LicenseActive":' '{print $2}' | awk -F',' '{print $1}' | tr -d ' ')
expiration_date=$(echo "$RESULT" | awk -F'"ExpirationDate":"' '{print $2}' | awk -F'"' '{print $1}')

########################################################
#### Lizenzstatus überprüfen und verbleibende Zeit anzeigen
if [ -n "$license_active" ]; then
  if [ "$license_active" = "true" ]; then
    current_date=$(date "+%Y-%m-%dT%H:%M:%S")
    
    # Konvertiere Ablaufdatum und aktuelles Datum in Sekunden seit der Epoche
    expiration_seconds=$(date -d "$expiration_date" "+%s")
    current_seconds=$(date -d "$current_date" "+%s")
    
    # Berechne die Differenz in Sekunden
    difference_seconds=$((expiration_seconds - current_seconds))
    
    # Berechne die verbleibenden Tage
    remaining_days=$((difference_seconds / 86400))  # 86400 Sekunden pro Tag

    if [ "$remaining_days" -gt 7 ]; then
      echo "Lizenz ist aktiv. Lizenz laeuft ab in $remaining_days Tagen.  ;  "
      exit 0
    else
      echo "Lizenz ist aktiv, aber abgelaufen. Ablaufdatum: $expiration_date  ; "
      exit 2
    fi
  else
    echo "Lizenz ist nicht aktiv  ;  ."
    exit 1
  fi
else
  echo "Server ist nicht erreichbar  ;  "
  exit 1
fi
