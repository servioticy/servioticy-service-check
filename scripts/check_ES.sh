# echo "*******************************"
# echo   ES nodes...
# echo "*******************************"

for es_node in `echo $ES_NODES | perl -pe "s/:/ /g"`
do
	response=$(curl --write-out %{http_code} --silent --head --output /dev/null http://$es_node:$ES_PORT)
	
	if [ $response != 200 ];
	then
		echo "KO... ES Service reachable in node $es_node -> response: "$response
	else
		echo "OK... ES Service reachable in node $es_node"
		es_healthy_node=$es_node
	fi
done


# echo "*******************************"
# echo   ES indices...
# echo "*******************************"


for index in $ES_INDICES
do
	if [ -z $es_healthy_node ];
	then
		echo "KO... ES $index index status could not be checked because no reachable nodes were available"
	else
		es_status_total=$(curl -s -X GET "http://$es_healthy_node:$ES_PORT/$index/_status?pretty" | head -6 | grep \"total\" | sed -e "s/ //g"| sed -e "s/,//g" | cut -d ":" -f 2)
		es_status_successful=$(curl -s -X GET "http://$es_healthy_node:$ES_PORT/$index/_status?pretty" | head -6 |grep \"successful\" | sed -e "s/ //g"| sed -e "s/,//g" | cut -d ":" -f 2)
		es_status_failed=$(curl -s -X GET "http://$es_healthy_node:$ES_PORT/$index/_status?pretty" | head -6 | grep \"failed\" | sed -e "s/ //g"| sed -e "s/,//g" | cut -d ":" -f 2)

		if [ $es_status_total -gt $es_status_successful  ];
		then
			echo "KO... ES $index index status -> shards successful:"$es_status_successful", failed: "$es_status_failed", total:"$es_status_total
		else
			echo "OK... ES $index index status -> shards successful:"$es_status_successful", failed: "$es_status_failed", total:"$es_status_total
		fi
		sleep 1
	fi

done
