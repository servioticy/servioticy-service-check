at=`cat $1/$IDS_FOLDER/$ACCESS_TOKEN_FILENAME`

for file in `ls $DPPS_FOLDER`
do
 id=`cat $1/$IDS_FOLDER/$file.id | perl -pe "s/\"/\n/g" | head -4 | tail -1`

 response=$(curl --digest -XGET \
     -H "Content-Type: application/json;charset=UTF-8" \
     -H "Authorization: $at"  \
     --write-out %{http_code} -s\
     -o $TMPDIR/$file.agg.data \
     http://$API_PUB_NODES:$API_PUB_SEC_PORT/$id/streams/$SAMPLE_DPP_AGG_STREAM)



     items=`cat $TMPDIR/$file.agg.data | perl -pe "s/[,:]/\n/g" | grep beacon | wc -l`
     expected_items=3


     if [ $response != 200 ];
     then
                echo "KO... Error retrieving data from DPP agg stream based on $file -> response: "$response
     else

         if [ $items -ne $expected_items  ]
         then
                echo "KO... Retrieved $items data items from DPP agg stream based on $file, ID: "$id", expected: "$expected_items
         else
                echo "OK... Retrieved $items data items from DPP agg stream based on $file, ID: "$id
         fi
     fi
done
