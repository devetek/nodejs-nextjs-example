#!/bin/bash

while true
do
  curl http://localhost:3001 -v > body
  sleep 2
done