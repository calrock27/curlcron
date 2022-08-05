#!/bin/sh

################################################################################
# INIT
################################################################################

# Provide CRON_TASK_* via environment variable
> /etc/crontabs/root
for item in `env`; do
   case "$item" in
       CRON_TASK*)
            ENVVAR=`echo $item | cut -d \= -f 1`
            printenv $ENVVAR >> /etc/crontabs/root
            echo "root" > /etc/crontabs/cron.update
            ;;
   esac
done

exec /usr/sbin/crond -f
