#!/bin/bash

while true
do
  curl http://localhost:3002 -v > body
  sleep 2
done