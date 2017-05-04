#!/bin/bash
#Script to test if defualt apache page is present is working
#the string apache appears 12 times so count that there is at least one
echo "Testing apache install"
success=`curl -s -m 5 127.0.0.1 | grep "apache" | wc -l`
echo $success
if [ "$success" -eq "12" ]
then
echo "Apache succesfully installed!"
else
echo "Something has gone wrong!"
fi
