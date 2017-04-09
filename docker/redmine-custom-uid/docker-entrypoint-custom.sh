#!/bin/bash
set -e

# Change this to your local user id (on the host)
# TODO: add autodetection
LOCAL_USER_ID=1000

PREFIX=""

case "$1" in
	rails|rake|passenger)
		PREFIX="/docker-entrypoint.sh"
	;;
esac

# Update UID + GID for user "redmine" to make the
# files accessible for the user on the host.
usermod -u ${LOCAL_USER_ID} redmine && groupmod -g ${LOCAL_USER_ID} redmine

# Change ownership of the files in /usr/src/redmine/
chown -R redmine:redmine /usr/src/redmine/

exec $PREFIX "$@"
