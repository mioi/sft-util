#!/bin/sh

# Set these environment variables:
# SFT_TEAM           Your Scaleft team name
# SFT_SLACK_WEBHOOK  The Slack incoming webhook
#
# Example usage:
# ./sft-util.sh <command>
#
# valid commands are either enroll or login
#

case $1 in
  enroll)
    MSG="Scaleft Client Enrollment Request"
    ;;
  login)
    MSG="Scaleft Client Login Request"
    ;;
  *)
    echo invalid command
    exit 1
    ;;
esac

sft $1 --team $SFT_TEAM 2>&1 | while read line; do
  if echo $line | egrep -q "^ *https:\/\/.*$"; then
    url=`echo $line | xargs`
    curl -s $SFT_SLACK_WEBHOOK -d '{"text":"['$HOSTNAME'] '"$MSG"': '$url'"}' > /dev/null 2>&1
  fi
done
