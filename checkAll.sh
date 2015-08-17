#!/bin/bash
. env.sh

START_FOLDER=$PWD

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