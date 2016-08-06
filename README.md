# sft-util

A little wrapper script I wrote for Ubuntu/Debian ScaleFT clients that don't have access to a web browser. This script will just basically send the URL to a Slack channel instead of trying to pull up a browser.

## Usage

```bash
./sft-util.rb --team TEAM_NAME --slack-webhook SLACK_WEBHOOK_URL enroll
./sft-util.rb --team TEAM_NAME --slack-webhook SLACK_WEBHOOK_URL login
```

## Requirements
  * Ruby (tested to work fine on 1.9 and 2)
  * A Slack custom integration - this will require you to click through some things in Slack and eventually you will get a webhook URL. You'll need this.

## TODO
  * make it better
  * maybe make it a gem
