#!/usr/bin/env ruby

require 'open3'
require 'optparse'
require 'shellwords'

team = ""
slack_webhook = ""
cmd = ""
regex = //
msg = ""

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: #{$0} [options] <command>"
  opts.on("--team TEAM", "Team name") {|o| team = Shellwords.escape(o) }
  opts.on("--slack-webhook URL", "Slack webhook url") {|o| slack_webhook = Shellwords.escape(o) }
  opts.on("--help", "Help") {|o| puts opts }
  opts.on_tail("Available commands:\n  enroll\n  login")
end.parse!

command = ARGV[0]

case command
when "enroll"
  cmd = "sft enroll --team #{team} 2>&1"
  regex = /https:\/\/.*scaleft.*approve/
  msg = "Scaleft Client Enrollment Requested"
when "login"
  cmd = "sft login --team #{team} 2>&1"
  regex = /https:\/\/.*scaleft.*client_logins[^" ]*/
  msg = "Scaleft Client Login Requested"
else
  abort "invalid command"
end

Open3.popen3(cmd) do |stdin, stdout, stderr|
  match = stdout.gets.match(regex)
  url = match[0]
  `curl -s #{slack_webhook} -d '{"text": "#{msg}: #{url}"}'`
  puts "Sent message to Slack!"
  puts "Waiting on approval..."
end

puts "Done."
