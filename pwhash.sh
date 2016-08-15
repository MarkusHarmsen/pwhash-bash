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
length=$(($length))
# At most 26 characters
if (( $length > 26 )); then
  length=26
fi

# Get password
echo -n "Password: "
read -s password

hash=$(echo -n "$tag" | openssl dgst -sha1 -hmac "$password" -binary | base64)
printf "%.${length}s" "$hash" | xclip -sel clip

echo ""
echo "The Password has been copied to clipboard"
