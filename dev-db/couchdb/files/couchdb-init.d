#!/sbin/openrc-run
# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

export COUCHDB_ARGS_FILE=${COUCHDB_ARGS_FILE:-/etc/couchdb/vm.args}
export COUCHDB_INI_FILES=${COUCHDB_INI_FILES:-"/etc/couchdb/default.ini /etc/couchdb/local.ini"}

pidfile="/run/${RC_SVCNAME}.pid"
command="/usr/lib/couchdb/bin/couchdb"
command_args="${COUCHDB_OPTS}"
command_background="true"
command_user="couchdb"
name="CouchDB Database"

depend() {
    use net
}
