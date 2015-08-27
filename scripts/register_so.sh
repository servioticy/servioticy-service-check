at=`cat $1/$IDS_FOLDER/$ACCESS_TOKEN_FILENAME`

for file in `ls $SOS_FOLDER`
do
  response=$(curl --digest -XPOST \
     --write-out %{http_code} \
     -H "Content-Type: application/json;charset=UTF-8" \
     -H "Authorization: $at" \
     -d @$1/$SOS_FOLDER/$file \
     -o $1/$IDS_FOLDER/$file.id -s \
     http://$API_PUB_NODES:$API_PUB_SEC_PORT)

     if [ $response != 201 ];
     then
                echo "KO... Error creating SO based on $file -> response: "$response
     else
		id=`cat $1/$IDS_FOLDER/$file.id | perl -pe "s/\"/\n/g" | head -4 | tail -1`
                echo "OK... Created SO based on $file, ID: "$id
     fi
  
done
