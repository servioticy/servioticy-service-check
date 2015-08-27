curl -s -H "Content-Type: application/json;charset=UTF-8" \
     -d '{"username":"'$IDM_USER'","password":"'$IDM_PASS'"}' \
     -X POST http://idm4.147.83.30.133.xip.io/auth/user/ \
     | perl -pe "s/\"/\n/g" | grep eyJhb \
     > $1/$IDS_FOLDER/$ACCESS_TOKEN_FILENAME 
