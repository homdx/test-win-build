#!/bin/bash

while sleep 60s; do echo "=====[ $SECONDS seconds still running ]====="; done & jom -s . && echo done build jom && kill %1
