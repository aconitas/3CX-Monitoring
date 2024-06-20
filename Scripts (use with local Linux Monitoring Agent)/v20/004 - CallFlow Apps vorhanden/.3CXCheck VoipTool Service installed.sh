##########################################################################
#
#   aconitas® GmbH · Bäumenheimer Str. 5 · 86690 Mertingen · Germany
#   https://www.aconitas.com · info@aconitas.com · +49 (906) 126725-0
#
#   Version 1.0 · 2022-12-15
#
##########################################################################

VoIPTools=$(systemctl list-units --type=service | grep voip)

if [[ $VoIPTools =~ 'voiptools' ]]; then
  echo VoIPTools Service installiert
  exit 2
else
  echo VoIPTools Service nicht installiert
  exit 0
fi
