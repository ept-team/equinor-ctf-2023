#!/bin/bash

while true; do
    openssl genrsa -out shitkey.pem 1024
    fingerprint=$(openssl pkey -in shitkey.pem -pubout -outform DER | openssl dgst -sha256)
    echo $fingerprint
    if [[ $fingerprint == "SHA2-256(stdin)= 37e3"* ]]; then
        echo "8J+kkyBJUS10b3BwZW5lIPCflKXwn5Sl" | base64 -d
        exit
    fi
done