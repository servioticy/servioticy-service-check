at=`cat $1/$IDS_FOLDER/$ACCESS_TOKEN_FILENAME`


id=`cat $1/$IDS_FOLDER/$SUBSCRIPTION_FILENAME.id | perl -pe "s/\"/\n/g" | head -4 | tail -1`
response=$(curl --digest -XDELETE \
     --write-out %{http_code} \
     -H "Content-Type: application/json;charset=UTF-8" \
     -H "Authorization: $at" \
     -o /dev/null -s \
     http://$API_PUB_NODES:$API_PUB_SEC_PORT/subscriptions/$id)

if [ $response != 204 ];
then
                echo "KO... Error deleting subscription -> response: "$response
else
                echo "OK... Deleted subscription, ID: "$id
fi
  
