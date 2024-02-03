# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: daemons.eclass
# @MAINTAINER:
# Anna <cyber+gentoo@sysrq.in>
# @AUTHOR:
# Anna <cyber+gentoo@sysrq.in>
# @SUPPORTED_EAPIS: 8
# @BLURB: eclass to test packages against running daemons
# @DESCRIPTION:
# A utility eclass providing functions for starting and stopping daemons with
# Pifpaf.
#
# This eclass does not set any metadata variables nor export any phase, so it
# can be inherited safely.
#
# @SUBSECTION Supported daemons
#
# - ceph
#
# - consul
#
# - httpbin
#
# - kafka
#
# - memcached
#
# - mysql
#
# - postgresql
#
# - redis
#
# - vault
#
# @EXAMPLE:
#
# @CODE
# EAPI=8
#
# ...
#
# DAEMONS_REQ_USE=(
# 	[postgresql]="xml"
# )
# inherit daemons distutils-r1
#
# ...
#
# distutils_enable_tests pytest
#
# daemons_enable postgresql test
#
# src_test() {
# 	daemons_start postgresql
# 	distutils-r1_src_test
# 	daemons_stop postgresql
# }
# @CODE

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI} unsupported."
esac

if [[ ! ${_DAEMONS_ECLASS} ]]; then
_DAEMONS_ECLASS=1

# @ECLASS_VARIABLE: DAEMONS_REQ_USE
# @PRE_INHERIT
# @DEFAULT_UNSET
# @DESCRIPTION:
# Bash associative array of USE flags required to be enabled on daemons,
# formed as a USE-dependency string.

# @ECLASS_VARIABLE: DAEMONS_DEPEND
# @OUTPUT_VARIABLE
# @DESCRIPTION:
# This is an eclass-generated bash associative array of dependency strings for
# daemons.
declare -Ag DAEMONS_DEPEND=()

# @FUNCTION: _daemons_set_globals
# @INTERNAL
# @DESCRIPTION:
# Set the DAEMONS_DEPEND variable.
_daemons_set_globals() {
	local -A pkgs=(
		[ceph]="sys-cluster/ceph"
		[consul]="app-admin/consul"
		[httpbin]="dev-python/httpbin"
		[kafka]="net-misc/kafka-bin"
		[memcached]="net-misc/memcached"
		[mysql]="virtual/mysql"
		[postgresql]="dev-db/postgresql"
		[redis]="dev-db/redis"
		[vault]="app-admin/vault"
	)

	local -A useflags=(
		[mysql]="server"
		[postgresql]="server"
	)

	if declare -p DAEMONS_REQ_USE &>/dev/null; then
		[[ $(declare -p DAEMONS_REQ_USE) == "declare -A"* ]] || \
			die "DAEMONS_REQ_USE must be declared as an associative array"
	fi

	local name dep usestr
	for name in "${!pkgs[@]}"; do
		dep=${pkgs[${name:?}]:?}
		usestr=${useflags[${name:?}]}
		usestr+=",${DAEMONS_REQ_USE[${name:?}]}"
		# strip leading/trailing commas
		usestr=${usestr#,}
		usestr=${usestr%,}

		[[ ${usestr?} ]] && usestr="[${usestr?}]"
		DAEMONS_DEPEND[${name:?}]="dev-util/pifpaf ${dep:?}${usestr?}"
	done

	readonly DAEMONS_DEPEND
}
_daemons_set_globals
unset -f _daemons_set_globals

# @FUNCTION: daemons_enable
# @USAGE: <daemon> <use>
# @DESCRIPTION:
# Add the daemon package to build-time dependencies under the given USE flag
# (IUSE will be set automatically).
daemons_enable() {
	debug-print-function ${FUNCNAME} "${@}"

	local daemon=${1:?}
	local useflag=${2:?}

	IUSE+=" ${useflag:?}"
	BDEPEND+=" ${useflag:?}? ( ${DAEMONS_DEPEND[${daemon:?}]:?} )"
	if [[ ${useflag:?} == "test" ]]; then
		RESTRICT+=" !test? ( test )"
	fi
}

# @FUNCTION: daemons_start
# @USAGE: <daemon> [args...]
# @DESCRIPTION:
# Start the daemon.  All arguments are passes to Pifpaf.
#
# Pifpaf will set some environment variables for you, they will be prefixed by
# uppercase daemon name.  See upstream documentation for details.
daemons_start() {
	debug-print-function ${FUNCNAME} "${@}"

	local daemon=${1:?}
	shift

	local logfile="${T?}/daemon-${daemon:?}.log"
	local tempfile="${T?}/daemon-${daemon:?}.sh"
	local myargs=(
		--env-prefix "${daemon^^}"
		--log-file "${logfile:?}"
		--verbose
	)

	ebegin "Starting ${daemon:?}"
	pifpaf "${myargs[@]}" run "${daemon:?}" "${@}" > "${tempfile:?}" && \
		source "${tempfile:?}" && \
		rm -f "${tempfile:?}"
	eend $? || die "Starting ${daemon:?} failed"
}

# @FUNCTION: daemons_stop
# @USAGE: <daemon>
# @DESCRIPTION:
# Stop a running daemon.
daemons_stop() {
	debug-print-function ${FUNCNAME} "${@}"

	local daemon=${1:?}
	local stop_fn="${daemon:?}_stop"
	declare -f "${stop_fn:?}" >/dev/null || die "${daemon:?} is not running"

	ebegin "Stopping ${daemon:?}"
	"${stop_fn:?}"
	eend $? || die "Stopping ${daemon:?} failed"
}

# @FUNCTION: daemons_death_notice
# @INTERNAL
# @DESCRIPTION:
# Creates archive with daemon logs and prints a log message with its location.
daemons_death_notice() {
	shopt -s nullglob
	local logfiles=( "${T}"/daemon-*.log )
	local logarchive="${T}/daemon-logs.tar.xz"
	shopt -u nullglob

	if [[ "${logfiles[*]}" ]]; then
		pushd "${T}" >/dev/null
		tar -acf "${logarchive}" "${logfiles[@]#${T}/}"
		popd >/dev/null
		eerror
		eerror "Please include ${logarchive} in your bug report."
		eerror
	fi
}
has daemons_death_notice ${EBUILD_DEATH_HOOKS} || EBUILD_DEATH_HOOKS+=" daemons_death_notice"

fi
