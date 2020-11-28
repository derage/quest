#!/bin/bash

openssl req -x509 -nodes -days 365 \
  -subj  "/C=CA/ST=QC/O=Company Inc/CN=example.com" \
  -newkey rsa:2048 -keyout /etc/ssl/private/selfsigned.key \
  -out /etc/ssl/certs/selfsigned.crt;

exec npm start