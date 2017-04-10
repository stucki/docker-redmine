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

if [ "$1" != 'rake' -a -z "$REDMINE_NO_DB_MIGRATE" ]; then
	# This is needed as long as https://github.com/docker-library/redmine/pull/10 is not merged:
	# Execute required DB migrations (for plugins, too!) before running the actual entrypoint script
	gosu redmine rake db:migrate redmine:plugins:migrate
fi

exec $PREFIX "$@"
