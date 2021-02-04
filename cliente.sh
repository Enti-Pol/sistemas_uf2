#!/bin/bash

PORT=8080

IP_CLIENTE="127.0.0.1"
IP_SERVER="127.0.0.1"

echo "Cliente de ABFP"

echo "(2) Sending Headers"

echo "ABFP $IP_CLIENT" | nc -q 1 $IP_SERVER $PORT

echo "(3)Listening $PORT"

nc -l -p $PORT
