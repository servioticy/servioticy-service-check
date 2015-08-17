# echo "*******************************"
# echo   STORM services...
# echo "*******************************"

for st_node in `echo $ST_NODES | perl -pe "s/:/ /g"`
do
	response=$(curl --silent http://$st_node:$ST_PORT/api/v1/cluster/summary | grep "stormVersion" | sed 's/ //g' | tail -1)
	if [ -z $response ];
	then
		echo "KO... STORM Service in node "$st_node
	else
		echo "OK... STORM Service reachable in node "$st_node
		st_healthy_node=$st_node
	fi
done




if [ -z $st_healthy_node ];
then
	echo "KO... STORM ACTIVE topologies could not be checked because no reachable nodes were available"
else

	for topology in `curl --silent http://$st_node:$ST_PORT/api/v1/topology/summary | perl -pe "s/},{/\n/g" | perl -pe "s/\[\{/\n/g" | grep -v "topologies" | grep "ACTIVE" | perl -pe "s/,/\n/g" | perl -pe  "s/\"//g" | grep name | cut -d ":" -f 2`
	do
		echo "OK... STORM topology deployed:" $topology", status: ACTIVE"
	done

fi


if [ -z $st_healthy_node ];
then
	echo "KO... STORM INACTIVE topologies could not be checked because no reachable nodes were available"
else

	for topology in `curl --silent http://$st_node:$ST_PORT/api/v1/topology/summary | perl -pe "s/},{/\n/g" | perl -pe "s/\[\{/\n/g" | grep -v "topologies" | grep "INACTIVE" | perl -pe "s/,/\n/g" | perl -pe  "s/\"//g" | grep name | cut -d ":" -f 2`
	do
		echo "OK... STORM topology deployed:" $topology", status: INACTIVE"
	done

fi

