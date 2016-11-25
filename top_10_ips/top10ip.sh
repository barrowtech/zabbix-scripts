#!/bin/bash
top10ip=$(awk -vDate=`date -d'now-1 hours' +[%d/%b/%Y:%H:%M:%S` ' { if ($4 > Date) print $1}' /var/log/nginx/hbbe-access_log | sort | uniq -c | sort -nr | head -n 10)
hitsperhour=$(awk -vDate=`date -d'now-1 hours' +[%d/%b/%Y:%H:%M:%S` ' { if ($4 > Date) print $4}' /var/log/nginx/hbbe-access_log | cut -d: -f1 | sort -n | uniq -c)
topip=$(awk -vDate=`date -d'now-1 hours' +[%d/%b/%Y:%H:%M:%S` ' { if ($4 > Date) print $1}' /var/log/nginx/hbbe-access_log | sort | uniq -c | sort -nr | head -n 1)
echo "'$top10ip'"
echo $hitsperhour
echo $topip
zabbix_sender -z zabbix.barrowtech.com -s "hb-web1" -k "topips" -o "'$topip'"
zabbix_sender -z zabbix.barrowtech.com -s "hb-web1" -k "hitsperhour" -o $hitsperhour
zabbix_sender -z zabbix.barrowtech.com -s "hb-web1" -k "topip" -o $topip

