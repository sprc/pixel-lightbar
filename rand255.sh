#!/bin/sh
echo $(od -An -N1 -t u1 /dev/urandom)
