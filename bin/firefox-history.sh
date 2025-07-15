#!/bin/bash
#
# 1. Work out which profile you want to look at history for:
# $ less ~/.mozilla/firefox/profiles.ini
# 2. Update the path to the SQL lite file below
# 3. Save this script
# 4. Make it executable:
# $ chmod +x ff-history.sh
# 5. Run it
# $ ./ff-history.sh
#
FFPROFILE_PATH1=~/.mozilla/firefox/i1a6efax.default-release
FFPROFILE_PATH2=~/.mozilla/firefox/ik77qlui.work-nzproxy/
TIMEZONE=1000
LIMIT=2000
cp -a "$FFPROFILE_PATH1/places.sqlite" "$FFPROFILE_PATH1/places_backup.sqlite"
cp -a "$FFPROFILE_PATH2/places.sqlite" "$FFPROFILE_PATH2/places_backup.sqlite"
(
sqlite3 -column "$FFPROFILE_PATH1/places_backup.sqlite" "SELECT datetime(visits.visit_date/1000000+(${TIMEZONE}/100)*60*60, 'unixepoch') AS date, substr(places.title,1,100), substr(places.url,1,100) FROM moz_historyvisits visits JOIN moz_places places ON visits.place_id = places.id ORDER BY visit_date DESC LIMIT $LIMIT;" 
sqlite3 -column "$FFPROFILE_PATH2/places_backup.sqlite" "SELECT datetime(visits.visit_date/1000000+(${TIMEZONE}/100)*60*60, 'unixepoch') AS date, substr(places.title,1,100), substr(places.url,1,100) FROM moz_historyvisits visits JOIN moz_places places ON visits.place_id = places.id ORDER BY visit_date DESC LIMIT $LIMIT;" ) | sort -rn | less -S
rm -f "$FFPROFILE_PATH1/places_backup.sqlite"
rm -f "$FFPROFILE_PATH2/places_backup.sqlite"
