# Adblocking "/etc/hosts"

**ATTENTION:**
Please read about the *[security concerns](https://notabug.org/jayvii/Scripts/src/master/README.md#attention)* of using random scripts from the internet

The script downloads several adblock-lists and places their content into your /etc/hosts, redirecting those domains to 0.0.0.0 (NULL).

This is a decent and effective way of blocking advertisement across all applications on your device and all devices connected to the internet through that device.

Substitude to "adblock" addons for your webbrowser.

## Adblock-lists

1. [(outdated) Disconnect-list](https://raw.githubusercontent.com/disconnectme/disconnect/b27abbf033c6f80f157fe9d98cb767c87065fbf4/firefox/content/disconnect.safariextension/opera/chrome/scripts/data.js)
2. [Adblock: Easylist](https://easylist-downloads.adblockplus.org/easylist.txt)
3. [Adblock: EasyPrivacy](https://easylist-downloads.adblockplus.org/easyprivacy.txt)
4. [Adblock: AntiAdblock](https://easylist-downloads.adblockplus.org/antiadblockfilters.txt)
5. [Adblock: Annoyancelist](https://easylist-downloads.adblockplus.org/fanboy-annoyance.txt)
6. [Adblock: Socialmedialist](https://easylist-downloads.adblockplus.org/fanboy-social.txt)
7. [WinHelp: Adblocking](http://winhelp2002.mvps.org/hosts.txt)
8. [Hostsfile: AntiAd & Protection](http://hosts-file.net/ad_servers.asp)
9. [Dan Pollock's AntiAd](http://someonewhocares.org/hosts/hosts)
10. [Adblock: AntiMalware](https://easylist-downloads.adblockplus.org/malwaredomains_full.txt) (disabled by default)



## Usage

Copy this file to a place you'll remember (eg: your home-directory).
Run:
> chmod +x /home/USER/.hostblockingscript

Now, you can run the script. As we do editing outside your home-folder, you need root-permissions. Note, that the script will also backup the original "/etc/hosts" file into your home-directory (~/.hostsbackup). This script needs to be run every now and then (I'd say every 2 weeks, min) to have full effect & protection.
> su -c "./home/USER/.hostblockingscript" root

or:
> sudo sh /home/USER/.hostblockingscript


## Screenshot
![Hostblockingscript](http://i.imgur.com/PrIro33.png)
