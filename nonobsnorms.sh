#!/bin/bash

# Author: stephen.farrell@cs.tcd.ie, use as you like

# This script takes an RFC number as input, pulls a HTML page
# from datatracker.ietf.org that contains the numbers of the
# other RFCs that referenc our target, then extracts from that
# the set of non-OBSOLETED RFCs that normatively refer to our
# target.

# Since answerin that question isn't often needed, this ia a
# pretty comprehensive hack:-)

# set -x

# the RFCs for which we wanna run this check
TARGETS="2246 4346"

TMPF=`mktemp /tmp/nonobsnormsXXXX`

for TARGET in $TARGETS
do

	curl https://datatracker.ietf.org/doc/rfc$TARGET/referencedby/ | \
			sed -n '/href="\/doc\/rfc[0-9][0-9][0-9]/,/eference/p'  | \
			grep -E '[[:space:]]href="/doc/rfc[0-9]{3,4}/"|eference' | \
			grep -v btn | \
			sed -e 's/^.*RFC //' | sed -e 's/<\/a>//' | sed -e 's/<td>//' | sed -e 's/<\/td>//' | \
			paste - - -d, | \
			sed -e 's/ //g' | \
			grep normative | \
			awk -F, '{print $1}' >>$TMPF

done

rlist=`cat $TMPF | sort -n | uniq`
for rfc in $rlist
do 
	obscount=`curl "https://datatracker.ietf.org/doc/rfc$rfc/" | grep -c Obsoleted`
	case "$obscount" in
			"0") echo "RFC$rfc seems to be live";;
			"1") echo "RFC$rfc seems to be obsoleted";;
			*) echo "Not sure about RFC$rfc - go check";;
	esac
done



# clean up
rm -f $TMPF

