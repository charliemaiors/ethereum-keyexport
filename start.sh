#! /bin/bash

nodejs PORT=8080 /root/keyExporter/bin/www > stdout.txt 2> stderr.txt
exec geth