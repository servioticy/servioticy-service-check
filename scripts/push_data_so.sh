
for file in `ls $SOS_FOLDER`
do
 id=`cat $1/$IDS_FOLDER/$file.id | perl -pe "s/\"/\n/g" | head -4 | tail -1`
 at=`cat $1/$IDS_FOLDER/$file.id | perl -pe "s/\"/\n/g" | head -8 | tail -1`

 response=$(curl --digest -XPUT \
     -H "Content-Type: application/json;charset=UTF-8" \
     -H "Authorization: $at"  \
     --write-out %{http_code} -s\
     -d @$1/$SODATA_FOLDER/$file \
     -o /dev/null \
     http://$API_PUB_NODES:$API_PUB_SEC_PORT/$id/streams/$SAMPLE_STREAM)


     if [ $response != 202 ];
     then
                echo "KO... Error pushing data to SO based on $file -> response: "$response
     else
                echo "OK... Pushed data to SO based on $file, ID: "$id
     fi
  
done

sleep 2
