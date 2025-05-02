#!/bin/bash

files='/data/tweets/geoTwitter21-01-01.zip
/data/tweets/geoTwitter21-01-02.zip
/data/tweets/geoTwitter21-01-03.zip
/data/tweets/geoTwitter21-01-04.zip
/data/tweets/geoTwitter21-01-05.zip
/data/tweets/geoTwitter21-01-06.zip
/data/tweets/geoTwitter21-01-07.zip
/data/tweets/geoTwitter21-01-08.zip
/data/tweets/geoTwitter21-01-09.zip
/data/tweets/geoTwitter21-01-10.zip'


echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
# FIXME: copy your solution to the previous problem here

# NOTE:
# I have removed the pg_normalized code from this repo.
# The only difference between pg_normalized and pg_normalized_batch is how the data is loaded.
# Since pg_normalized_batch is faster,
# we will use that code to load the data.

# time ( echo "$files" | parallel ./load_denormalized.sh )

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
# FIXME: copy your solution to the previous problem here
time parallel ./load_normalized_batch.sh ::: $files

