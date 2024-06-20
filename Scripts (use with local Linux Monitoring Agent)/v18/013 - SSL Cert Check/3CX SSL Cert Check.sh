##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 1.0 · 2022-12-15
#
##########################################################################

########################################################
#### Import FQDN aus 3CX DB
FQDN=$(sudo -u postgres psql -d database_single -c "SELECT * FROM parameter where name='WEB_ROOT_EXT_SEC'" | grep WEB_ROOT_EXT_SEC | tr -s ' ' | cut -d ' ' -f7)

########################################################
#### Auswertung Restlaufzeit
Restlaufzeit=$(curl $FQDN -vI --stderr - | grep "expire date:" | cut -d: -f 2-)
Convert=$(date --date="$Restlaufzeit" '+%s')

########################################################
#### Auswertung aktuelles Datum
Datum_Aktuell=$(date '+%s')

########################################################
#### Auswertung restliche Laufzeit in Tagen
Restlaufzeit=$(( ($Convert-$Datum_Aktuell)/86400 ))

if [[ $Restlaufzeit -le $Error ]]; then
   echo  ACHTUNG: Das Zertifikat $FQDN laeuft in $Restlaufzeit Tagen aus
   echo Aussteller: $(curl $FQDN -vI --stderr - | grep "issuer:" | cut -d: -f 2-)
   exit 1
elif [[ $Restlaufzeit -gt $Warning ]]; then
   echo  Das Zertifikat $FQDN laeuft in $Restlaufzeit Tagen aus
   echo Aussteller: $(curl $FQDN -vI --stderr - | grep "issuer:" | cut -d: -f 2-)
   exit 0
else
   echo ACHTUNG: Das Zertifikat $FQDN laeuft in $Restlaufzeit Tagen aus
   echo Aussteller: $(curl $FQDN -vI --stderr - | grep "issuer:" | cut -d: -f 2-)
   exit 2
fi
