#!/bin/sh

# Anew without golang
xanew() { awk 'hit[$0]==0 {hit[$0]=1; print $0}'; }
which anew &>/dev/null || alias anew=xanew

# Create the files
URLLIST=$(mktemp urllist.XXXXXX)
URLLIST2=$(mktemp urllist.XXXXXX)
SEEN="seen"

# Feed the URLLIST with the seeds
cat seed > "$URLLIST"
cat "$URLLIST" | anew "$SEEN"

while [ -s "$URLLIST" ] ; do
	cat "$URLLIST" |
		parallel proxychains4 -q lynx -listonly -image_links -dump {} \; \
			echo Spidered: {} \>\&2 |
			perl -ne 's/#.*//; s/\s+\d+.\s(\S+)$/$1/ and do { $seen{$1}++ or print }' |
			perl -ne 'print if m|^(?:https?://)?(?:[a-zA-Z0-9-]+\.)?[a-zA-Z0-9-]+\.onion(?:/.*)?$|' |
		awk 'NR==FNR{seen[$0]; next} !($0 in seen)' "$SEEN" - | anew "$SEEN" > "$URLLIST2"
	mv "$URLLIST2" "$URLLIST"
done

rm -f "$URLLIST" "$URLLIST2"
