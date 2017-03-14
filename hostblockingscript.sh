#!/bin/bash
# Credits to "Ben" (Administrator) from CupOfLinux.

# check for root rights
if [ ! $(whoami) == root ]; then
	echo "Please run this script with root-rights!"
	echo "su -c \"sh hostblockingscript.sh\" root"
	echo "sudo ./hostblockingscript.sh"
	exit 1;
fi

# backup "/etc/hosts"
if [ ! -f /etc/hosts.BAK ]; then
	cp /etc/hosts /etc/hosts.BAK
fi

# counting blocked domains
Blockeddomainsold=$(cat /etc/hosts | grep "0.0.0.0" | wc -l)

# temporary files to safe blocked domains
Selfdestructinghosts=$(mktemp)
Selfdestructinghosts2=$(mktemp)

# User-output
echo ""
echo "[ HOSTBLOCKINGSCRIPT ]"
echo "https://notabug.org/jayvii/Scripts/src/master/Adblocking"
echo ""
echo "##########"

# download lists

echo "Getting (outdated) DisconnectMe-list..."
wget -q -O - https://raw.githubusercontent.com/disconnectme/disconnect/b27abbf033c6f80f157fe9d98cb767c87065fbf4/firefox/content/disconnect.safariextension/opera/chrome/scripts/data.js >> $Selfdestructinghosts

echo "Getting Adblock Easy-list..."
wget -q -O - https://easylist-downloads.adblockplus.org/easylist.txt >> $Selfdestructinghosts

echo "Getting Adblock EasyPrivacy-list..."
wget -q -O - https://easylist-downloads.adblockplus.org/easyprivacy.txt >> $Selfdestructinghosts

echo "Getting Adblock AntiAdblock-list..."
wget -q -O - https://easylist-downloads.adblockplus.org/antiadblockfilters.txt >> $Selfdestructinghosts

echo "Getting Adblock MalewareDomain-list..."
wget -q -O - https://easylist-downloads.adblockplus.org/malwaredomains_full.txt >> $Selfdestructinghosts

echo "Getting Adblock FanboyAnnoyance-list..."
wget -q -O - https://easylist-downloads.adblockplus.org/fanboy-annoyance.txt >> $Selfdestructinghosts

echo "Getting FanboySocial-list..."
wget -q -O - https://easylist-downloads.adblockplus.org/fanboy-social.txt >> $Selfdestructinghosts

echo "Getting Winhelp2002 Hosts-list..."
wget -q -O - http://winhelp2002.mvps.org/hosts.txt >> $Selfdestructinghosts

echo "Getting HostsFile AdServer-list..."
wget -q -O - http://hosts-file.net/ad_servers.asp >> $Selfdestructinghosts

echo "Getting SomeoneWhoCares Hosts-file..."
wget -q -O - http://someonewhocares.org/hosts/hosts >> $Selfdestructinghosts

echo "Getting NoTrack Trackers-list..."
wget -q -O - https://raw.githubusercontent.com/quidsup/notrack/master/trackers.txt >> $Selfdestructinghosts

echo "Getting NoTrack MaliciousSites-list..."
wget -q -O - https://raw.githubusercontent.com/quidsup/notrack/master/malicious-sites.txt >> $Selfdestructinghosts

echo "Getting MalewareDomainList Hosts-list..."
wget -q -O - http://www.malwaredomainlist.com/hostslist/hosts.txt >> $Selfdestructinghosts

echo "Getting Spam404 Hosts-list..."
wget -q -O - https://raw.githubusercontent.com/Dawsey21/Lists/master/adblock-list.txt >> $Selfdestructinghosts

# https://raw.githubusercontent.com/disconnectme/disconnect-tracking-protection/master/services.json
# https://s3.amazonaws.com/lists.disconnect.me/entitylist.json

sed -e 's/\r//' -e '/^0.0.0.0/!d' -e '/localhost/d' -e 's/0.0.0.0/0.0.0.0/' -e 's/ \+/\t/' -e 's/#.*$//' -e 's/[ \t]*$//' < $Selfdestructinghosts | sort -u > $Selfdestructinghosts2

# create a master hosts file
echo -e "\n#Hostslist created "$(date) | cat /etc/hosts.BAK - $Selfdestructinghosts2 > /etc/hosts.NEW

# cleaning
rm -rf $Selfdestructinghosts $Selfdestructinghosts2

# replace current /etc/hosts with our new one.
cp /etc/hosts.NEW /etc/hosts

# counting blocked domains
Blockeddomainsnew=$(cat /etc/hosts | grep "0.0.0.0" | wc -l)

# final output for user
if [ "$1" == "libnotify" ]; then
	notify-send "HostBlockingScript" "Done! Replaced $Blockeddomainsold with $Blockeddomainsnew blocks." -t 0
else
	echo "##########"
	echo ""
	echo "Done!"
	echo "Previously blocked domains: $Blockeddomainsold"
	echo "Currently blocked domains:  $Blockeddomainsnew"
fi
