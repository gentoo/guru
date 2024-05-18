#!/bin/sh

# Thanks To tastytea for the script <https://schlomp.space/tastytea/overlay/src/branch/master/dev-util/lua-language-server/files/wrapper-r1.sh>

# Some paths must be writable, so we put them into user-owned directories

DATAPATH="${XDG_DATA_HOME:-${HOME}/.local/share}/lua-language-server"
STATEPATH="${XDG_STATE_HOME:-${HOME}/.local/state}/lua-language-server"

mkdir --parents ${DATAPATH} ${STATEPATH}

exec @GENTOO_PORTAGE_EPREFIX@/opt/lua-language-server/bin/lua-language-server \
	--logpath="${STATEPATH}/log" \
	--metapath="${DATAPATH}/meta" \
	"${@}"
