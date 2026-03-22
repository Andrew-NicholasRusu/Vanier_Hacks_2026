#!/usr/bin/env bash

secret=$(strings ./satellite.exe | grep -i "secret")

# decode the string in base64
decoded_secret=$(echo "$secret" | base64 --decode)

echo "flag: $decoded_secret"