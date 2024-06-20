##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 1.0 · 2022-12-15
#
##########################################################################

UT=$(uptime | cut -d ' '  -f 4)
echo "Uptime = $UT Tage"
if [[ $UT -gt 365 ]]; then
   exit 2
else
   exit 0
fi
