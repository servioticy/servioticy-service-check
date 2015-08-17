# echo "*******************************"
# echo   Broker services...
# echo "*******************************"
response=$(curl --write-out %{http_code} --silent --head --output /dev/null -u "$BR_USER:$BR_PASS" http://$BR_NODE:$BR_BROKER_PORT/broker/connectors.json)
if [ $response != 200 ];
then
	echo "KO... Broker Service -> response: "$response
else
	echo "OK... Broker Service"
fi
# echo "*******************************"
# echo   Broker connectors...
# echo "*******************************"
connectors=`curl -s -u "$BR_USER:$BR_PASS" http://$BR_NODE:$BR_BROKER_PORT/broker/connectors.json | perl -pe "s/,/\n/g" |grep \"state\" | wc -l`
if [ $connectors != $EXPECTED_APOLLO_TCP_CONNECTORS ];
then
	echo "KO... Broker Connectors -> #connectors STARTED:"$connectors" instead of "$EXPECTED_APOLLO_TCP_CONNECTORS
else
	echo "OK... Broker Connectors"

fi