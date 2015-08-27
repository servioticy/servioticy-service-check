at=`cat $1/$IDS_FOLDER/$ACCESS_TOKEN_FILENAME`

curl -H "Content-Type: application/json;charset=UTF-8" \
     -H "Authorization: Bearer $at" \
     -X GET http://idm4.147.83.30.133.xip.io/idm/user/info/ -s \
     | perl -pe "s/\"/\n/g" | tail -2 | head -1 \
     > $1/$IDS_FOLDER/$RANDOM_ACCESS_TOKEN_FILENAME 
