#!/bin/bash
. env.sh

START_FOLDER=$PWD

mkdir -p $IDS_FOLDER

$SCRIPTS/get_access_token.sh $START_FOLDER
$SCRIPTS/register_so.sh $START_FOLDER
$SCRIPTS/push_data_so.sh $START_FOLDER
$SCRIPTS/retrieve_data_so.sh $START_FOLDER
$SCRIPTS/delete_data_so.sh $START_FOLDER
$SCRIPTS/retrieve_no_data_so.sh $START_FOLDER
$SCRIPTS/delete_so.sh $START_FOLDER


exit

echo
echo "*********************************"
echo servIoTicy services status 
echo `date`
echo "*********************************"
echo

$SCRIPTS/check_CB.sh
$SCRIPTS/check_ES.sh
$SCRIPTS/check_kestrel.sh
$SCRIPTS/check_storm.sh
$SCRIPTS/check_apollo.sh
$SCRIPTS/check_API.sh


