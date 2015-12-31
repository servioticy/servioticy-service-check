at=`cat $1/$IDS_FOLDER/$ACCESS_TOKEN_FILENAME`


for file in `ls $SOS_FOLDER | head -1`
do

  id=`cat $1/$IDS_FOLDER/$file.id | perl -pe "s/\"/\n/g" | head -4 | tail -1`
  response=$(curl --digest -XPOST \
     --write-out %{http_code} \
     -H "Content-Type: application/json;charset=UTF-8" \
     -H "Authorization: $at" \
     -d @$1/$SUBS_FOLDER/$SUBSCRIPTION_FILENAME \
     -o $1/$IDS_FOLDER/$SUBSCRIPTION_FILENAME.id -s \
     http://$API_PUB_NODES:$API_PUB_SEC_PORT/$id/streams/$SAMPLE_STREAM/subscriptions)

     if [ $response != 201 ];
     then
                echo "KO... Error creating subscription -> response: "$response
     else
    id=`cat $1/$IDS_FOLDER/$SUBSCRIPTION_FILENAME.id | perl -pe "s/\"/\n/g" | head -4 | tail -1`
                echo "OK... Created subscription, ID: "$id
     fi

done
