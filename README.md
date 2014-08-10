clearinhouse_roller
===================

A simple set of shellscripts that roll a Seattle Testbed/clearinhouse server

# Some dependencies

* Django
* Apache
* Mysql
* libmysqlclient-dev
* Django-python-pymsql
* django-social-auth

Consult the [clearinghouse wiki](https://seattle.poly.edu/wiki/SeattleGeniInstallation) for a full list.

# To use:

run get_sources.sh

create a clearinghouse database in mysql

run ./deploy.sh

That's it!
