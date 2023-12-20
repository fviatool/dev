#!/bin/bash

# Function to generate a new IPv6 address
get_new_ipv6() {
    random_ipv6=$(openssl rand -hex 8 | sed 's/\(..\)/:\1/g; s/://1')
    echo "$random_ipv6"
}

# Function to update 3proxy configuration with a new IPv6 address
update_3proxy_ipv6_config() {
    new_ipv6=$1
    sed -i "s/old_ipv6_address/$new_ipv6/" /usr/local/etc/3proxy/3proxy.cfg
}

# Function to restart 3proxy
restart_3proxy() {
    /usr/local/etc/3proxy/bin/3proxy /usr/local/etc/3proxy/3proxy.cfg
}

echo "Rotating IPv6 addresses for 3proxy every 10 minutes..."

# Get the list of existing IPv6 addresses from the 3proxy configuration
ipv6_list=$(grep -oP "(?<=-i)[^ ]*" /usr/local/etc/3proxy/3proxy.cfg)

# Loop through each IPv6 address, update the configuration, and restart 3proxy
for old_ipv6 in $ipv6_list; do
    new_ipv6=$(get_new_ipv6)
    update_3proxy_ipv6_config "$new_ipv6"
done

restart_3proxy

echo "IPv6 rotation for 3proxy completed."
