#!/bin/bash -e

# Tag
tag=${1}
# If not provided, read tag
if [ "$tag" == "" ]; then
  read -p "Tag: " tag
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
read -p "Password: " -s password

# Compute hash (e.g HMAC with tag and password)
hash=$(echo -n "$tag" | openssl dgst -sha1 -hmac "$password" -binary | base64)
# Copy to clipboard with given length
printf "%.${length}s" "$hash" | xclip -sel clip

printf "\nThe Password has been copied to clipboard\n"
