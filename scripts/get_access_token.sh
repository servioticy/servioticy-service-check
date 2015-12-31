curl -s -X GET 'http://'$IDM_HOST':'$IDM_PORT'/identity/auth/'$IDM_USER \
     > $1/$IDS_FOLDER/$ACCESS_TOKEN_FILENAME
