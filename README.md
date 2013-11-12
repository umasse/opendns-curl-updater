opendns-curl-updater
====================

Simple Bash script to update OpenDNS dynamic IP using cUrl, specifying interface.

To use, put it, for example, in /usr/local/bin.

Then use your system's crontab to make it run every 5 minutes.
I also add one more cron task every 4 hours to delete the IP cached address file, to force a refresh.
