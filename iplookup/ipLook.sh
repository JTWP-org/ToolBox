#!/bin/bash
#run script then pass ip for arg returns api request 

echo $(date +%c) $( curl "http://ipwho.is/${1}" |  jq -j '.ip, " ",.country, " :flag!",.country_code,": ", .connection.isp,  "\n"' | tr '!' '_'   | tr '[:upper:]' '[:lower:]')  
