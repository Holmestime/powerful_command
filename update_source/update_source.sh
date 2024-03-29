#!/bin/bash

VERSION="focal"  # precise is code of Ubuntu 12.04 if your ubuntu is not 12.04 please change
TEST_NETCONNECT_HOST="www.baidu.com"
SOURCES_MIRRORS_FILE="sources_mirrors.list"	
MIRRORS_SPEED_FILE="mirrors_speed.list"

function get_ping_speed()	#return average ping $1 time
{
	local speed=`ping -W1 -c1 $1 2> /dev/null | grep "^rtt" |  cut -d '/' -f5`
	echo $speed
}

function test_mirror_speed()	#
{
	rm $MIRRORS_SPEED_FILE 2> /dev/null; touch $MIRRORS_SPEED_FILE

    cat $SOURCES_MIRRORS_FILE | while read mirror
	do
		if [ "$mirror" != "" ]; then
			echo -e "Ping $mirror \c"
			local mirror_host=`echo $mirror | cut -d '/' -f3`	#change mirror_url to host
	
			local speed=$(get_ping_speed $mirror_host)
	
			if [ "$speed" != "" ]; then
				echo "Time is $speed"
				echo "$mirror $speed" >> $MIRRORS_SPEED_FILE
			else
				echo "Connected failed."
			fi
		fi
	done
}

function get_fast_mirror()
{
	 sort -k 2 -n -o $MIRRORS_SPEED_FILE $MIRRORS_SPEED_FILE
	 local fast_mirror=`head -n 1 $MIRRORS_SPEED_FILE | cut -d ' ' -f1`
	 echo $fast_mirror
}

function backup_sources()
{
    echo -e "Backup your sources.list.\n"
    sudo mv /etc/apt/sources.list /etc/apt/sources.list.`date +%F-%R:%S`
}

function update_sources()
{
    local COMP="main restricted universe multiverse"
    local mirror="$1"
    local tmp=$(mktemp) 

	echo "deb $mirror $VERSION $COMP" >> $tmp
	echo "deb $mirror $VERSION-updates $COMP" >> $tmp
	echo "deb $mirror $VERSION-backports $COMP" >> $tmp 
	echo "deb $mirror $VERSION-security $COMP" >> $tmp
	echo "deb $mirror $VERSION-proposed $COMP" >> $tmp

	echo "deb-src $mirror $VERSION $COMP" >> $tmp 
	echo "deb-src $mirror $VERSION-updates $COMP" >> $tmp 
	echo "deb-src $mirror $VERSION-backports $COMP" >> $tmp 
	echo "deb-src $mirror $VERSION-security $COMP" >> $tmp 
	echo "deb-src $mirror $VERSION-proposed $COMP" >> $tmp

    sudo mv "$tmp" /etc/apt/sources.list
    echo -e "Your sources has been updated, and maybe you want to run \"sudo apt-get update\" now.\n";
}

echo -e "\nTesting the network connection.\nPlease wait...   \c"

if [ "$(get_ping_speed $TEST_NETCONNECT_HOST)" == "" ]; then
	echo -e "Network is bad.\nPlease check your network."; exit 1
else
	echo -e "Network is good.\n"
	test -f $SOURCES_MIRRORS_FILE

	if [ "$?" != "0" ]; then  
		echo -e "$SOURCES_MIRRORS_FILE is not exist.\n"; exit 2
	else
		test_mirror_speed
		fast_mirror=$(get_fast_mirror)

		if [ "$fast_mirror" == "" ]; then
			echo -e "Can't find the fastest software sources. Please check your $SOURCES_MIRRORS_FILE\n"
			exit 0
		fi

		echo -e "\n$fast_mirror is the fastest software sources. Do you want to use it? [y/n] \c"	
		read choice

		if [ "$choice" != "y" ]; then
			exit 0
		fi

		backup_sources
		update_sources $fast_mirror
	fi
fi
	
exit 0