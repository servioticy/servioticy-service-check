at=`cat $1/$IDS_FOLDER/$ACCESS_TOKEN_FILENAME`

for file in SO1.json SO2.json SO3.json
do
   id=`cat $1/$IDS_FOLDER/$file.id | perl -pe "s/\"/\n/g" | head -4 | tail -1`
   curl --digest -XDELETE \
     -H "Content-Type: application/json;charset=UTF-8" \
     -H "Authorization: $at" \
     http://$API_PUB_NODES:$API_PUB_SEC_PORT/$id
done
