#!/bin/sh

# Replace "endtime": -1 with "endtime": 999999999999 in /www/server/panel/data/plugin.json
sed -i 's|"endtime": -1|"endtime": 999999999999|g' /www/server/panel/data/plugin.json

# Replace "pro": -1 with "pro": 0 in /www/server/panel/data/plugin.json
sed -i 's|"pro": -1|"pro": 0|g' /www/server/panel/data/plugin.json

# Set immutable attribute for /www/server/panel/data/plugin.json
chattr +i /www/server/panel/data/plugin.json
