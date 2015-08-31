#!/bin/bash
. env.sh

START_FOLDER=$PWD

mkdir -p $IDS_FOLDER

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

$SCRIPTS/get_access_token.sh $START_FOLDER
$SCRIPTS/get_random_access_token.sh $START_FOLDER
$SCRIPTS/register_so.sh $START_FOLDER
$SCRIPTS/register_dpp.sh $START_FOLDER
$SCRIPTS/create_subscription.sh $START_FOLDER
$SCRIPTS/start_subscriber.sh $START_FOLDER
$SCRIPTS/push_data_so.sh $START_FOLDER
sleep 3
$SCRIPTS/verify_subscription_data.sh $START_FOLDER
$SCRIPTS/retrieve_subscription.sh $START_FOLDER
$SCRIPTS/retrieve_private_subscription.sh $START_FOLDER
$SCRIPTS/delete_subscription.sh $START_FOLDER
$SCRIPTS/retrieve_data_so.sh $START_FOLDER
$SCRIPTS/delete_data_so.sh $START_FOLDER
$SCRIPTS/retrieve_no_data_so.sh $START_FOLDER
$SCRIPTS/delete_dpp.sh $START_FOLDER
$SCRIPTS/delete_so.sh $START_FOLDER
