This tool allows developers to securely share sensitive documents. Files are encrypted before transfer using age, sent over SSH using scp, and verified for integrity using SHA-256 checksums. Every transfer is logged automatically.
```
# Folder Structure
secure-share/
├── send.sh          # Encrypt and transfer a file to a recipient
├── receive.sh       # Decrypt a received file and verify its integrity
├── setup_keys.sh    # Generate SSH and age keys for a new user
├── transfer.log     # Auto-generated transfer log (sender side)
├── README.md        # This file
```
