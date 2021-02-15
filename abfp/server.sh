#!/bin/bash

PORT=2021

echo "(0) Servidor ABFP"

echo "(1) Listening $PORT"

HEADER=`nc -l -p $PORT`

echo "TEST! $HEADER"

PREFIX=`echo $HEADER | cut -d " " -f 1`
IP_CLIENT=`echo $HEADER | cut -d " " -f 2`

echo "(4) RESPONSE"

if [ $PREFIX != "ABFP" ]; then
	
	echo "Error en la cabecera"
	
	sleep 1
	echo "KO_CONN" | nc -q 1 $IP_CLIENT $PORT
	
	exit 1
fi

echo "OK_CONN" | nc -q 1 $IP_CLIENT $PORT

echo "(5) Listen"

HANDSHAKE=`nc -l -p $PORT`

sleep 1

echo "(8) RESPONSE"
if [ $HANDSHAKE != "THIS_IS_MY_CLASSROOM" ]; then
	
	echo "Error en el HANDSHAKE"

	echo "KO_HANDSHAKE" | nc -q 1 $IP_CLIENT $PORT

	exit 1

fi

echo "YES_IT_IS" | nc -q 1 $IP_CLIENT $PORT

echo "(9) Listen"

RESPONSE=`nc -l -p $PORT`

echo "(12) Response"

sleep 1

MD5SERVER=`echo "$RESPONSE" | md5sum | cut -d " " -f 1`

echo "RECIEVED" | nc -q 1 $IP_CLIENT $PORT

echo "(13) Listen"

MD5CLIENT=`nc -l -p $PORT | cut -d " " -f 1`

echo "(16) RESPONSE"

sleep 1

echo "$MD5SERVER $MD5CLIENT"

if [ $MD5SERVER != $MD5CLIENT ]; then

  echo "Incorrect md5"
	echo "KO_MD5" | nc -q 1 $IP_CLIENT $PORT

  exit 1

fi

echo "OK_MD5" | nc -q 1 $IP_CLIENT $PORT

exit 0
