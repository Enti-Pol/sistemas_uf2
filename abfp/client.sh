#!/bin/bash

PORT=2021

IP_CLIENTE="127.0.0.1"
IP_SERVER="127.0.0.1"

echo "Cliente de ABFP"

echo "(2) Sending Headers"

echo "ABFP $IP_CLIENTE" | nc -q 1 $IP_SERVER $PORT

echo "(3)Listening $PORT"

RESPONSE=`nc -l -p $PORT`

if [ "$RESPONSE" != "OK_CONN" ]; then

	echo "No se ha podido conectar con el servidor"
	exit 1
fi

echo "(6) HANDSHAKE"

sleep 1
echo "THIS_IS_MY_CLASSROOM" | nc -q 1 $IP_SERVER $PORT

echo "(7) Listen"

RESPONE=`nc -l -p $PORT`

sleep 1

echo "(10) Send Name File"

echo "cliente.sh" | nc -q 1 $IP_SERVER $PORT

echo "(11) Listen"

RESPONSE=`nc -l -p $PORT`

echo "(14) Send md5"

sleep 1

echo "cliente.sh" | md5sum | nc -q 1 $IP_SERVER $PORT

echo "(15) Listen"

RESPONSE=`nc -l -p $PORT`

echo "$RESPONSE"

exit 0
