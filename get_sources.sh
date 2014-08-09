#!/bin/bash

echo "getting the clearing house sources..."
git clone -b django16support git@github.com:/santiagotorres/clearinghouse

echo "getting the repy/seattlelib/portability sources..."
git clone git@github.com:/seattletestbed/seattlelib_v2
git clone git@github.com:/seattletestbed/repy_v2
git clone git@github.com:/seattletestbed/portability

echo "all sources should be here now"
echo "please create the seattlegeni database and update the credentials in"
echo "deploy.sh"
