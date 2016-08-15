#!/bin/bash

# Tag
tag=${1}
# If not provided, read tag
if [ "$tag" == "" ]; then
  echo -n "Tag: "
  read tag
fi

# Optional second argument length
length=${2:-16}
# Ensure integer
length=$(($length+0))
# At most 26 characters
if (( $length > 26 )); then
  length=26
fi

# Get password
echo -n "Password: "
stty -echo
read password
stty echo

hash=$(echo -n "$tag" | openssl dgst -sha1 -hmac "$password" -binary | base64)
printf "%.${length}s\n" "$hash" | xclip -sel clip

echo ""
echo "The Password has been copied to clipboard"
