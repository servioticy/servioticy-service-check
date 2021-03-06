at=`cat $1/$IDS_FOLDER/$ACCESS_TOKEN_FILENAME`


id=`cat $1/$IDS_FOLDER/$SUBSCRIPTION_FILENAME.id | perl -pe "s/\"/\n/g" | head -4 | tail -1`
response=$(curl --digest -XGET \
     --write-out %{http_code} \
     -H "Content-Type: application/json;charset=UTF-8" \
     -H "Authorization: $at" \
     -o $1/$IDS_FOLDER/$SUBSCRIPTION_FILENAME.id.private.retrieved -s \
     http://$API_PUB_NODES:$API_PUB_SEC_PORT/private/security/subscriptions/$id)

if [ $response != 200 ];
then
                echo "KO... Error retrieving private subscription -> response: "$response
else
                echo "OK... Retrieved private subscription, ID: "$id
fi
  
