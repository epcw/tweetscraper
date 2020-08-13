#!/bin/bash

# This is the revised Trump Watch scraper that pulls using the Premium API's 30day endpoint (up to 500 at a time, 250 pulls per month).  To switch to full archive, replace "30day" with "fullarchive" in tweet.sh (up to 100 at a time, 50 pulls per month)

#usage ./trumpwatch.sh {QUERY}
#query must be un url format: i.e. usps%20%22no%20access%22

#raw command line for tester purposes that pulls the whole .json of the last 30 days:  ./tweet.sh search -q from:realDonaldTrump","maxResults":500 | jq '.["results"] | .[].extended_tweet | .full_text'

today=$(date +%Y%m%d) #normal one for day-of.
#today="$1" #if you need to add a date

pull=$(python3 /home/pzed/Dropbox/Github/tweetscraper/search-tweets-python/tools/search_tweets.py --max-results 500 --filter-rule "$1" --filename-prefix tweetscraper_$today --credential-file /home/pzed/Dropbox/Github/tweetscraper/search-tweets-python/tools/.twitter_keys.yaml --no-print-stream)

  echo $pull

>/home/pzed/Dropbox/Github/tweetscraper/tweetscraper_$today.csv

#set variables and parse json with jq
id=$(cat tweetscraper_$today.json | jq '.id_str')
fulltext=$(cat tweetscraper_$today.json | jq '.extended_tweet | .full_text' | sed -e 's/null//g')
shorttext=$(cat tweetscraper_$today.json | jq '.text')
created_at=$(cat tweetscraper_$today.json | jq '.created_at')

#account for short tweets by taking the $shorttext value when $fulltext is an empty string
merge=$(paste <(echo "$id") <(echo "$created_at") <(echo "$fulltext") <(echo "$shorttext") -d ',')
echo "$merge" | sed -e 's/\"\,\"/\"\|\"/g' -e 's/\"\,\,\"/\"\|\|\"/g' | awk -F '|' -v OFS='|' '$1 { if ($3=="") $3=$4; print $1, $2, $3}' >> /home/pzed/Dropbox/Github/tweetscraper/tweetscraper1_$today.csv

#print column names to output file
echo "id|created at|text|tags|notes" > /home/pzed/Dropbox/Github/tweetscraper/tweetscraper_$toda  y.csv

cat /home/pzed/Dropbox/Github/tweetscraper/tweetscraper1_$today.csv >> /home/pzed/Dropbox/Github/tweetscraper/tweetscraper_$today.csv
rm /home/pzed/Dropbox/Github/tweetscraper/tweetscraper1_$today.csv
