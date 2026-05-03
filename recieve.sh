#!/bin/bash
# receive.sh - Decrypt and verify a received file
# Usage: ./receive.sh <encrypted_file.age> <checksum_file.sha256>

ENCRYPTED_FILE="$1"
CHECKSUM_FILE="$2"
OUTPUT_FILE="${ENCRYPTED_FILE%.age}"

# step 1 - decrypt
echo "Decrypting file..."
age --decrypt -i ~/file_key.txt -o "$OUTPUT_FILE" "$ENCRYPTED_FILE"
echo "Decryption done."

# step 2 - verify checksum
echo "Verifying checksum..."
ACTUAL=$(sha256sum "$OUTPUT_FILE" | awk '{print $1}')
EXPECTED=$(awk '{print $1}' "$CHECKSUM_FILE")

if [ "$ACTUAL" = "$EXPECTED" ]; then
    echo "INTEGRITY CHECK: PASSED. File is safe."
else
    echo "INTEGRITY CHECK: FAILED. File may be tampered."
    rm -f "$OUTPUT_FILE"
fi
