at=`cat $1/$IDS_FOLDER/$ACCESS_TOKEN_FILENAME`
mkdir -p $TMPDIR

for file in `ls $SOS_FOLDER | head -1`
do

  id=`cat $1/$IDS_FOLDER/$file.id | perl -pe "s/\"/\n/g" | head -4 | tail -1`
  rm -rf $TMPDIR/$SAMPLE_SUBSCRIPTION_DATA
  echo "      Subscribing to topic /topic/"$at"."$id".streams."$SAMPLE_STREAM".updates"
  $NODE_HOME/bin/node $SCRIPTS/subscriber.js $at $id $SAMPLE_STREAM > $TMPDIR/$SAMPLE_SUBSCRIPTION_DATA &

  sleep 1

done
