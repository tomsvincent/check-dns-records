#!/bin/bash
website=$1

#To get the IP address of the website
echo "IP address of $website"
IP=`dig  +short $website`
echo -e "$IP \n"

#To get the hostname of the website
echo "Hostname of $website"
host $IP | awk -F ' ' '{print $5}'

#To get the nameservers of the website
echo -e "\nNameservers of $website"
dig +short $website NS

#To get the MX record of the website
echo -e "\nMailservers of $website"
dig +short $website MX

#To get registrar details from the whois output 
echo -e "\nWHOIS of $website "
whois $website | grep -A 3 -i -e "Updated Date"

#To get nameservers from the WHOIS information
echo -e "\nWhois Nameservers"
whois $website|grep -iw  " Name server"
if [ $? -eq 1 ]; then
whois $website |grep -A2 "Name servers:"
fi
if [ $? -eq 1 ]; then
whois $website |grep "Name Server:"
fi
if [ $? -eq 1 ]; then
whois $website |grep -A3 "Domain servers"
fi
