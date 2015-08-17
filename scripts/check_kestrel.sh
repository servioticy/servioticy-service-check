# echo "*******************************"
# echo   Kestrel services...
# echo "*******************************"

for ks_node in `echo $KS_NODES | perl -pe "s/:/ /g"`
do
	response=$(printf "STATUS\nquit" | curl --silent -m 1 telnet://$ks_node:$KS_PORT  | tr -d '[[:space:]]')
	if [ $response != "UP" ];
	then
		echo "KO... Kestrel Service in node "$ks_node"-> response: "$response
	else
		echo "OK... Kestrel Service UP in node "$ks_node
	fi
done

