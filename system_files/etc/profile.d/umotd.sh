#!/bin/sh
# Orca OS Message of the Day (Replaces upstream Bluefin umotd)

if [ -t 1 ] && [ "${SHLVL:-1}" -le 2 ] && [ -z "${ORCA_MOTD_SHOWN:-}" ]; then
    export ORCA_MOTD_SHOWN=1
    if [ -f /etc/motd ]; then
        cat /etc/motd
    fi
fi
