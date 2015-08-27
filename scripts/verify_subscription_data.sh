TMPDIR=$1/tmp
out=`cat $TMPDIR/$SAMPLE_SUBSCRIPTION_DATA | grep current-value`

if [ ! -z $out ];
then

	echo "OK... verifying subscription data"
else
	echo "KO... verifying subscription data. No current-value found as it was expected"
	pkill -9 node
fi

