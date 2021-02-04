#!/bin/bash

PORT=2021

echo "(0) Servidor ABFP"

echo "(1) Listening $PORT"

HEADER=`nc -l -p $PORT`

echo "TEST! $HEADER"

echo $HEADER | cut -d " "
