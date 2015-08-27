at=`cat $1/$IDS_FOLDER/$ACCESS_TOKEN_FILENAME`

for file in SO1.json SO2.json SO3.json
do
  curl --digest -XPOST \
     -H "Content-Type: application/json;charset=UTF-8" \
     -H "Authorization: $at" \
     -d @$1/$SOS_FOLDER/$file \
     -o $1/$IDS_FOLDER/$file.id -s \
     http://$API_PUB_NODES:$API_PUB_SEC_PORT
done
