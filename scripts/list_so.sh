at=`cat $1/$IDS_FOLDER/$ACCESS_TOKEN_FILENAME`

curl --digest -XGET \
     -H "Content-Type: application/json;charset=UTF-8" \
     -H "Authorization: $at" \
     http://$API_PUB_NODES:$API_PUB_SEC_PORT
