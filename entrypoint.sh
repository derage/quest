#!/bin/bash

# if generated cert isnt mounted, generate one.
if [ ! -f "/home/app/cert/selfsigned.key" ]; then
  mkdir -p /home/app/cert
  SAN=${SAN:-localhost}
  echo "
  [req]
  distinguished_name=req
  [san]
  subjectAltName=DNS:${SAN}" > config-ssl
  openssl req \
          -x509 \
          -newkey rsa:4096 \
          -sha256 \
          -days 3560 \
          -nodes \
          -keyout /home/app/cert/selfsigned.key \
          -out /home/app/cert/selfsigned.crt \
          -subj '/CN=cafarelli.org' \
          -extensions san \
          -config config-ssl
fi


exec npm start