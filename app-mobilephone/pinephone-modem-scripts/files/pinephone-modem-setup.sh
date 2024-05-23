#!/bin/sh

log() {
	echo "$@" | logger -t "manjaro:modem-setup"
}

QMBNCFG_CONFIG="1"

# Read current config
QMBNCFG_ACTUAL_CONFIG=$(echo 'AT+QMBNCFG="AutoSel"' | atinout - $DEV -)

if echo $QMBNCFG_ACTUAL_CONFIG | grep -q $QMBNCFG_CONFIG
then
	log "Modem already configured"
	exit 0
fi


# Configure VoLTE auto selecting profile
RET=$(echo "AT+QMBNCFG=\"AutoSel\",$QMBNCFG_CONFIG" | atinout - $DEV -)
if ! echo $RET | grep -q OK
then
	log "Failed to enable VoLTE profile auto selecting: $RET"
	exit 1
fi
