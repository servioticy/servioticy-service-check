# echo "*******************************"
# echo   CB nodes...
# echo "*******************************"

for cb_node in `echo $CB_NODES | perl -pe "s/:/ /g"`
do
  response=$(curl --write-out %{http_code} --silent --head --output /dev/null http://$cb_node:$CB_PORT/pools)

  if [ $response != 200 ];
  then
    echo "KO... CB Service reachable in node $cb_node -> response: "$response
  else
    echo "OK... CB Service reachable in node $cb_node"
    cb_healthy_node=$cb_node
  fi
done

# echo "*******************************"
# echo   CB cluster service...
# echo "*******************************"

if [ -z $cb_healthy_node ];
then
  echo "KO... CB ClusterService status could not be checked because no reachable nodes were available"
else
  cb_status=$(curl -s -X GET http://$cb_healthy_node:$CB_PORT/pools/default | grep status |grep -s healthy | sed 's/ //g' | tail -1)
  if [ -z $cb_status ];
  then
    echo "KO... CB Cluster Service status"
  else
    echo "OK... CB Cluster Service status"
  fi
fi

for bucket in $CB_BUCKETS
do
  if [ -z $cb_healthy_node ];
  then
    echo "KO... CB $bucket bucket status could not be checked because no reachable nodes were available"
  else
    cb_status=$(curl -s -X GET http://$cb_healthy_node:$CB_PORT/pools/default/buckets/$bucket | grep status |grep -s healthy | sed 's/ //g' | tail -1)
    if [ -z $cb_status ];
    then
      echo "KO... CB $bucket bucket status"
    else
      echo "OK... CB $bucket bucket status"
    fi
  fi

done
