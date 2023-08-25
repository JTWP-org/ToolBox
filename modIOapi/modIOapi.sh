#PAVLOV IS 3959
gameID="3959"
# where to find https://cdn.discordapp.com/attachments/949594481223684106/1135702542077153411/1.png
apiKEY="IAMNOTAKEY"
#where to find https://cdn.discordapp.com/attachments/949594481223684106/1135701913996886036/1.png
apiPATH="IAMNOTAPATH"


curl -X GET "${apiPATH}/games/${gameID}/mods/${1}?api_key=${apiKEY}"   -H 'Accept: application/json' | jq . > rawAPI.tmp

cat rawAPI.tmp | jq '.logo.original, .name'
