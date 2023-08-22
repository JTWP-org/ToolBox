#!/bin/bash
PASSWORD="$(echo -n ${1} | md5sum  )"
echo $PASSWORD | tr -d ' -'