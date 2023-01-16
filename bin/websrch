#!/bin/bash
echo "enter your search strings"
read shearch_item
Eshearch_item=$(echo $shearch_item | sed 's/\ /+/g')
echo https://duckduckgo.com/?q=$Eshearch_item | xargs w3m 
