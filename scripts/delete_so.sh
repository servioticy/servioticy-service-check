at=`cat $1/$IDS_FOLDER/$ACCESS_TOKEN_FILENAME`

for file in `ls $SOS_FOLDER`
do
   id=`cat $1/$IDS_FOLDER/$file.id | perl -pe "s/\"/\n/g" | head -4 | tail -1`
   response=$(curl --digest -XDELETE -s \
     --write-out %{http_code} \
	  -o /tmp/so_del.txt \
     -H "Content-Type: application/json;charset=UTF-8" \
     -H "Authorization: $at" \
     http://$API_PUB_NODES:$API_PUB_SEC_PORT/$id)


     if [ $response != 204 ];
     then
                echo "KO... Error deleting SO based on $file -> response: "$response
     else
                id=`cat $1/$IDS_FOLDER/$file.id | perl -pe "s/\"/\n/g" | head -4 | tail -1`
                echo "OK... Deleted SO based on $file, ID: "$id
     fi
done
