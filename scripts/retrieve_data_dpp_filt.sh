at=`cat $1/$IDS_FOLDER/$ACCESS_TOKEN_FILENAME`

for file in `ls $DPPS_FOLDER`
do
 id=`cat $1/$IDS_FOLDER/$file.id | perl -pe "s/\"/\n/g" | head -4 | tail -1`

 response=$(curl --digest -XGET \
     -H "Content-Type: application/json;charset=UTF-8" \
     -H "Authorization: $at"  \
     --write-out %{http_code} -s\
     -o $TMPDIR/$file.filt.data \
     http://$API_PUB_NODES:$API_PUB_SEC_PORT/$id/streams/$SAMPLE_DPP_FILT_STREAM)

     items=`cat $TMPDIR/$file.filt.data | perl -pe "s/[,:]/\n/g" | grep beacon | wc -l`
     expected_items=2


     if [ $response != 200 ];
     then
                echo "KO... Error retrieving data from DPP filt stream based on $file -> response: "$response
     else

	 if [ $items -ne $expected_items  ]
	 then
                echo "KO... Retrieved $items data items from DPP filt stream instead of "$expected_items",  based on $file, ID: "$id
	 else
                echo "OK... Retrieved $items data items from DPP filt stream based on $file, ID: "$id
 	 fi
     fi
  
done
