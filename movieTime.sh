#!/bin/bash
DIR=$1
MPLAYER="/usr/bin/mplayer"
TOTAL=0
for FILE in $DIR*
do 
	if [[ -f $FILE ]] && ([ ${FILE: -4} == ".m4v" ] || [ ${FILE: -4} == ".mp4" ] || [ ${FILE: -4} == ".mkv" ] || [ ${FILE: -4} == ".avi" ]); then	
		DETAILS=$($MPLAYER -vo null -ao null -frames 0 -identify "$FILE" 2>/dev/null)
		SECFLOAT=(${DETAILS#*ID_LENGTH=*})
		SEC=${SECFLOAT%%.*}
		TOTAL=`expr $SEC + $TOTAL`
		echo $SEC $FILE
	fi
done
echo ""
echo $TOTAL seconds
MINS=`expr $TOTAL / 60`
SECS=`expr $TOTAL % 60`
HOURS=`expr $MINS / 60`
MINS=`expr $MINS % 60`
echo $(printf %02d $HOURS)h:$(printf %02d $MINS)m:$(printf %02d $SECS)s