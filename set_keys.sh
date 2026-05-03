#!/bin/bash	
touch key
ssh-keygen -t ed25519 -f key -N ""
age-keygen -o file_key.txt
