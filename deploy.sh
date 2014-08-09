#!/bin/bash

# Reset pythonpath
unset PYTHONPATH

export PYTHONPATH=$PYTHONPATH:$PWD/tmp/:$PWD/tmp/seattle:$PWD/tmp/seattlegeni/
export DJANGO_SETTINGS_MODULE=seattlegeni.website.settings

# remove old instance of deployed server
if [ -e tmp ]
then
    rm -vrf tmp
fi

# deploy
python clearinghouse/deploymentscripts/deploy_clearinghouse.py  . tmp

# copy seattle and repy sources here
cp -r repy_v2/* tmp/seattle
cp -r portability/* tmp/seattle
cp -r seattlelib_v2/* tmp/seattle
cp -r statekeys tmp/seattlegeni/node_state_transitions/

# initialize our settings file with minimal settings
sed -i "s/SECRET_KEY\ =\ ''/SECRET_KEY = 'wowsuchsecret'/g" tmp/seattlegeni/website/settings.py
sed -i "s/'NAME':\ 'FILL_THIS_IN'/'NAME': 'seattlegeni'/g" tmp/seattlegeni/website/settings.py
sed -i "s/'USER':\ 'FILL_THIS_IN'/'USER': 'root'/g" tmp/seattlegeni/website/settings.py
sed -i "s/'PASSWORD':\ 'FILL_THIS_IN'/'PASSWORD': 'rawr12'/g" tmp/seattlegeni/website/settings.py

# cd to newly deployed clearinghouse and patch import statements in repy files
cd tmp
find -name "*.r2py" -exec sed -i "s/dy_import_module('/dy_import_module('..\/seattle\//g" {} \;

cd seattlegeni
# run the keyserver daemon... 
python lockserver/lockserver_daemon.py &> lockserver.log &

# run!
python website/manage.py syncdb
python website/manage.py runserver
