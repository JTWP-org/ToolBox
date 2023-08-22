#!/bin/bash
steamID=$1
curl -X GET "http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=${API}&steamids=${1}" -H 'Accept: application/json'  > out.api

