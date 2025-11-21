#!/usr/bin/env sh

# Files
SEEN="seen"

# Check if previous urls files still exists
if ls urllist* &>/dev/null; then
	# Use the previous files
	URLLIST=$(ls urllist1*)
	URLLIST2=$(ls urllist2*)
else
	# Create the files
	URLLIST=$(mktemp urllist1.XXXXXX)
	URLLIST2=$(mktemp urllist2.XXXXXX)
	# Feed the URLLIST with the seeds
	cat seed > "$URLLIST"
fi

# If the seen file does not have content
# Feed it with the URLLIST
if [ ! -s ${SEEN} ]; then
	cat "$URLLIST" > "$SEEN"
fi

while [ -s "$URLLIST" ] ; do
	cat "$URLLIST" |
		parallel -j100 proxychains4 -q lynx -read_timeout=300 -connect_timeout=180 -listonly -image_links -dump {} \; \
			echo Spidered: {} \>\&2 |
			perl -ne 's/#.*//; s/\s+\d+.\s(\S+)$/$1/ and do { $seen{$1}++ or print }' |
			perl -ne 'print if m|^(?:https?://)?(?:[a-zA-Z0-9-]+\.)?[a-zA-Z0-9-]+\.onion(?:/.*)?$|' |
		awk 'NR==FNR{seen[$0]; next} !($0 in seen)' "$SEEN" - | tee -a "$SEEN" > "$URLLIST2"
	mv "$URLLIST2" "$URLLIST"
done

rm -f "$URLLIST" "$URLLIST2"
