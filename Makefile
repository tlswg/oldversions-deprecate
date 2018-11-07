# XML2RFC=/Users/paul/Documents/xml2rfc-1.35/xml2rfc.tcl
XML2RFC=xml2rfc

DATE=`date +%s`

all: core 

core: 
	$(XML2RFC) draft-ietf-tls-oldversions-deprecate.xml draft-ietf-tls-oldversions-deprecate.txt

upload:
	scp draft-ietf-tls-oldversions-deprecate.txt  down.dsg.cs.tcd.ie:/var/www/misc/draft-ietf-tls-oldversions-deprecate.txt
	scp draft-ietf-tls-oldversions-deprecate.xml  down.dsg.cs.tcd.ie:/var/www/misc/draft-ietf-tls-oldversions-deprecate.xml

backuup:
	- mkdir backups
	cp draft-ietf-tls-oldversions-deprecate.txt backups/draft-ietf-tls-oldversions-deprecate-$(DATE).txt
	cp draft-ietf-tls-oldversions-deprecate.xml backups/draft-ietf-tls-oldversions-deprecate-$(DATE).xml

clean:
	rm -f   draft-ietf-tls-oldversions-deprecate.txt *~

nonobsnorms: nonobsnorms.sh
	./onobsnorms.sh
