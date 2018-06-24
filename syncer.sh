#!/bin/bash

REPO_DIR=$1
shift
DIRS=$@


echo "Repository is located at "$REPO_DIR
echo "Configuration dirs are located at "$DIRS

HOSTNAME=$(hostname)
TODAY=$(date +"%Y-%m-%d")
HOUR=$(date +"%H")

echo "Hostname is "$HOSTNAME
echo "Today is "$TODAY

git pull
git checkout master

rsync -av $DIRS $REPO_DIR
find /root/configurations/* -exec git add {} \; git pull

git commit -a -m "Configuration updated at $(date)"
git push

# create branch if last day hour came
if [ $HOUR = "23" ];
then
	git checkout -b $TODAY
	git push origin $TODAY
	git checkout master
fi
