#!/bin/sh
# Update the pihole list with youtube ads 
# this shell script is made by Kiro 
#Thank you for using it and enjoy 

# The script will create a file with all the youtube ads found in hostsearch and from the logs of the Pi-hole
# it will append the list into a file called blacklist.txt'/etc/pihole/blacklist.txt'

piholeIPV4=$(hostname -I |awk '{print $1}')
piholeIPV6=$(hostname -I |awk '{print $2}')


blackListFile='/etc/pihole/black.list'
blacklist='/etc/pihole/blacklist.txt'

# Get the list from the GitHub and add it to the blacklist.txt 
sudo curl 'https://raw.githubusercontent.com/kboghdady/youTube_ads_4_pi-hole/master/black.list'\
>>$blacklist
sudo curl 'https://raw.githubusercontent.com/kboghdady/youTube_ads_4_pi-hole/master/black.list'\
>>$blackListFile

# Get the list from the GitHub and add it to the blacklist.txt with Pihole IPV4 and IPV6 to black.list
sudo curl 'https://raw.githubusercontent.com/kboghdady/youTube_ads_4_pi-hole/master/black.list' |awk -v a=$piholeIPV4 '{print a " " $1}'|sort |uniq>>$blackListFile
sudo curl 'https://raw.githubusercontent.com/kboghdady/youTube_ads_4_pi-hole/master/black.list' |awk -v a=$piholeIPV6 '{print a " " $1}'|sort |uniq>>$blackListFile

wait 
# remove the duplicate records in place
gawk -i inplace '!a[$0]++' $blackListFile
wait 
gawk -i inplace '!a[$0]++' $blacklist
