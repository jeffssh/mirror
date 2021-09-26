#!/usr/bin/env bash

docker build -t jeffssh/mirror:latest .
docker push jeffssh/mirror:latest
