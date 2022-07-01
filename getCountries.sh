# This is the file needed to retrieve all the JSON from the API
# This should be only needed to update the JSON files if revolut made changes to the API
# Usually you won't have to call this at all and we do not recommend doing it since it requires you to extract your revolut access_token from the browser

function getFieldsCountry {
	COUNTRY=$1
	STATUS=$2
	STATUS_LOWERCASE=$(echo $STATUS | tr '[:upper:]' '[:lower:]')

	# All the environmental variables needed to make the request can extracted from an actual request made from the revolut business web application.
	# Revolut security policy is strict and require you to send a lot of additional information to the API to make a request as if it was made from the browser you got your token from.
	# The following variables are the ones needed to make the request BUSINESS_ACCOUNT_ID, USER_AGENT, X_VERIFICATION_CHANNEL, X_DEVICE_ID, ACCESS_TOKEN.
	# The token is very short-lived, since we don't refresh it ourselves, I would recommend to launch the script just after the "refresh" route is called in the browser with the new token set in the "set-cookies" header.
	# I would recommend doing it from an account with only the "create counterparty" privilege to not compromise revolut security.
	curl -s "https://business.revolut.com/api/business/$BUSINESS_ACCOUNT_ID/counterparty/external/fields?bankCountry=$COUNTRY&currency=USD&type=$STATUS&routingType=ACH" \
		-H "User-Agent: $USER_AGENT" \
		-H 'Accept: application/json, text/plain, */*' \
		-H 'Accept-Language: en-US,en;q=0.5' \
		-H 'Accept-Encoding: gzip, deflate, br' \
		-H 'Referer: https://business.revolut.com/' \
		-H "X-VERIFICATION-CHANNEL: $X_VERIFICATION_CHANNEL" \
		-H "X-DEVICE-ID: $X_DEVICE_ID" \
		-H 'Alt-Used: business.revolut.com' \
		-H 'Connection: keep-alive' \
		-H "Cookie: G_ENABLED_IDPS=google; disableAnalyticsEventsTracking=true; token=$ACCESS_TOKEN" \
		-H 'Sec-Fetch-Dest: empty' \
		-H 'Sec-Fetch-Mode: cors' \
		-H 'Sec-Fetch-Site: same-origin' \
		-H 'Pragma: no-cache' \
		-H 'Cache-Control: no-cache' \
		-H 'TE: trailers' --output - | gzip -d > ${STATUS_LOWERCASE}/${COUNTRY}.json
}

while read line; do
	getFieldsCountry $line COMPANY
	getFieldsCountry $line INDIVIDUAL
	echo $line
done < countries.csv
