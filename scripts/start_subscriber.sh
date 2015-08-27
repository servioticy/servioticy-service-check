#at=`cat $1/$IDS_FOLDER/$ACCESS_TOKEN_FILENAME`

for file in `ls $SOS_FOLDER | head -1`
do

  id=`cat $1/$IDS_FOLDER/$file.id | perl -pe "s/\"/\n/g" | head -4 | tail -1`
  at=`cat $1/$IDS_FOLDER/$file.id | perl -pe "s/\"/\n/g" | head -8 | tail -1`
  
  node $SCRIPTS/subscriber.js $at $id $SAMPLE_STREAM &
  
  sleep 1

done
