#!/usr/bin/env bash

/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -s | grep "Pretty fly for a WiFi" >> /dev/null

if [ $? -eq 0 ]; then
  /Users/daniel/.rbenv/shims/terminal-notifier -message "You forgot to turn your MiFi off!" -title "Hey Idiot"
fi
