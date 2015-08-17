# echo "*******************************"
# echo   API nodes...
# echo "*******************************"

for api_node in `echo $API_PRIV_NODES | perl -pe "s/:/ /g"`
do
	response=$(curl --write-out %{http_code} --silent --head --output /dev/null http://$api_node:$API_PRIV_NOSEC_PORT)
	
	if [ $response != 403 ];
	then
		echo "KO... API INTERNAL Non-Secure Service reachable in node $api_node:$API_PRIV_NOSEC_PORT -> response: "$response
	else
		echo "OK... API INTERNAL Non-Secure Service reachable in node $api_node:$API_PRIV_NOSEC_PORT"
	fi
done

for api_node in `echo $API_PRIV_NODES | perl -pe "s/:/ /g"`
do
	response=$(curl --write-out %{http_code} --silent --head --output /dev/null http://$api_node:$API_PRIV_SEC_PORT)
	
	if [ $response != 403 ];
	then
		echo "KO... API INTERNAL Secure Service reachable in node $api_node:$API_PRIV_SEC_PORT -> response: "$response
	else
		echo "OK... API INTERNAL Secure Service reachable in node $api_node:$API_PRIV_SEC_PORT"
	fi
done

for api_node in `echo $API_PUB_NODES | perl -pe "s/:/ /g"`
do
	response=$(curl --write-out %{http_code} --silent --head --output /dev/null http://$api_node:$API_PUB_NOSEC_PORT)
	
	if [ $response != 403 ];
	then
		echo "KO... API PUBLIC Non-Secure Service reachable in node $api_node:$API_PUB_NOSEC_PORT -> response: "$response
	else
		echo "OK... API PUBLIC Non-Secure Service reachable in node $api_node:$API_PUB_NOSEC_PORT"
	fi
done

for api_node in `echo $API_PUB_NODES | perl -pe "s/:/ /g"`
do
	response=$(curl --write-out %{http_code} --silent --head --output /dev/null http://$api_node:$API_PUB_SEC_PORT)
	
	if [ $response != 403 ];
	then
		echo "KO... API PUBLIC Secure Service reachable in node $api_node:$API_PUB_SEC_PORT -> response: "$response
	else
		echo "OK... API PUBLIC Secure Service reachable in node $api_node:$API_PUB_SEC_PORT"
	fi
done
