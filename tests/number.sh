#!/bin/bash 
[ -z "${1//[0-9]}" ] && [ -n "$1" ] || echo "Sorry integers only"