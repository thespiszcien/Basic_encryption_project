#!/bin/bash
# send.sh - Encrypt and send a file
# Usage: ./send.sh <file> <recipient_age_pubkey> <user@host:/path/>

FILE="$1"
RECIPIENT_PUBKEY="$2"
REMOTE_DEST="$3"
FILENAME=$(basename "$FILE")
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%S")

# step 1 - generate checksum
echo "Generating checksum..."
sha256sum "$FILE" > /tmp/$FILENAME.sha256
CHECKSUM=$(sha256sum "$FILE" | awk '{print $1}')
echo "Checksum done: $CHECKSUM"

# step 2 - encrypt
echo "Encrypting file..."
age -r "$RECIPIENT_PUBKEY" -o /tmp/$FILENAME.age "$FILE"
echo "Encryption done."

# step 3 - transfer
echo "Transferring file..."
scp /tmp/$FILENAME.age /tmp/$FILENAME.sha256 "$REMOTE_DEST"
echo "Transfer done."

# step 4 - log
echo "$TIMESTAMP | $(whoami) | $REMOTE_DEST | $FILENAME | sha256:$CHECKSUM | SUCCESS" >> transfer.log
echo "Logged."

# step 5 - cleanup
rm -f /tmp/$FILENAME.age /tmp/$FILENAME.sha256
echo "Done! File sent successfully."
