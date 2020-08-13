# Tweetscraper
Forked from [twitterdev](https://github.com/twitterdev/search-tweets-python/tree/master), and adapted to allow a command-line query using the premium Twitter API, either with the 30day endpoint (500 max tweets pulled at once) or the full-archive endpoint (100 max tweets pulled at once).  You must ALREADY have a premium / enterprise dev twitter account for this to work.

# Usage instructions
Note: queries must be in url format: i.e. term%20%22quoted%20term%22.  Dates must be in YYYY-MM-DD format\
* Pull (up to) last 500 tweets: ./tweetscraper-pull.sh query
* Pull (up to) 100 tweets from some old date (no date range limit): ./tweetscraper-pull-olddate.sh startdate enddate query
* Pull (up to) 500 tweets from some old date (30 day date range limit): ./tweetscraper-pull-olddate500.sh startdate enddate query
* Process a json already pulled: ./tweetscraper-nopull.sh

# Setup
1. Install Python3
2. Install jq (sudo apt-get install jq on ubuntu/debian)
3. Install searchtweets (pip install searchtweets)
4. Replace YOUR_KEY_HERE and YOUR_SECRET_HERE in /search-tweets-python/tools/.twitter_keys.yaml & /search-tweets-python/tools/.twitter_keys_all.yaml
