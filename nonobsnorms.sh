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

# output files...
# these files are to be manually included in the XML2RFC source

# updates header
UHEAD="$0.updates-header"
# normative references xml
NREFS="$0.refs"
# Para that has references
NPARA="$0.para"
# informationals
IREFS="$0.irefs"
# para for those
IPARA="$0.ipara"
# ENTITY statements
ESTAT="$0.entity"

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
normlist=""
inflist=""
oddlist=""
for rfc in $rlist
do 
	obscount=`curl "https://datatracker.ietf.org/doc/rfc$rfc/" | grep -c Obsoleted`
	case "$obscount" in
			"0") echo "RFC$rfc seems to be live"; normlist="$rfc $normlist";;
			"1") echo "RFC$rfc seems to be obsoleted"; inflist="$rfc $inflist";;
			*) echo "Not sure about RFC$rfc - go check"; oddlist="$rfc $oddlist";;
	esac
done

if [ -f $UHEAD ]
then
	mv $UHEAD $UHEAD.old
fi
echo "$normlist" >$UHEAD

if [ -f $NREFS ]
then
	mv $NREFS $NREFS.old
fi
if [ -f $NPARA ]
then
	mv $NPARA $NPARA.old
fi
if [ -f $IREFS ]
then
	mv $IREFS $IREFS.old
fi
if [ -f $IPARA ]
then
	mv $IPARA $IPARA.old
fi
if [ -f $ESTAT ]
then
	mv $ESTAT $ESTAT.old
fi

for rfc in $normlist
do
	echo "<?rfc include='reference.RFC.$rfc'?>" >>$NREFS
	echo "<xref target='RFC$rfc'/>" >>$NPARA
done

for rfc in $inflist
do
	echo "<?rfc include='reference.RFC.$rfc'?>" >>$IREFS
	echo "<xref target='RFC$rfc'/>" >>$IPARA
done

for rfc in $rlist
do
	echo "<!ENTITY rfc$rfc SYSTEM 'https://xml.resource.org/public/rfc/bibxml/reference.RFC.$rfc.xml'>" >>$ESTAT
done

# clean up
rm -f $TMPF

