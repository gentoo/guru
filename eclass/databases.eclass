# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: databases.eclass
# @MAINTAINER:
# Anna <cyber+gentoo@sysrq.in>
# @AUTHOR:
# Anna <cyber+gentoo@sysrq.in>
# @SUPPORTED_EAPIS: 8
# @BLURB: eclass to test packages against databases
# @DESCRIPTION:
# A utility eclass providing functions for running databases.
#
# This eclass does not set any metadata variables nor export any phase, so it
# can be inherited safely.
#
# @SUBSECTION Supported databases
#
# - memcached (via "ememcached" helper)
#
# - MongoDB (via "emongod" helper)
#
# - MySQL / MariaDB (via "emysql" helper)
#
# - PostgreSQL (via "epostgres" helper)
#
# - Redis (via "eredis" helper)
#
# @SUBSECTION Helper usage
#
# --add-deps <use>
#
# 	Adds the server package to build-time dependencies under the given USE flag
# 	(IUSE will be set automatically).
#
# --die [msg]
#
#	Prints the path to the server's log file to the console and aborts the
#	current merge process with the given message.
#
# --get-dbpath
#
# 	Returns the directory where the server stores database files.
#
# --get-logfile
#
# 	Returns the path to the server's log file.
#
# --get-pidfile
#
# 	Returns the path to the server's PID file.
#
# --get-sockdir
#
# 	Returns the directory where the server's sockets are located.
#
# --get-sockfile
#
# 	Returns the path to the server's socket file.
#
# --start
#
# 	Starts the server on the default port.
#
# --start <port>
#
# 	Starts the server on the given port.
#
# --stop
#
# 	Stops the server.
#
# @EXAMPLE:
#
# @CODE
# EAPI=8
#
# ...
#
# DATABASES_REQ_USE=(
# 	[postgres]="xml"
# )
# inherit databases distutils-r1
#
# ...
#
# distutils_enable_tests pytest
#
# epostgres --add-deps test
#
# src_test() {
# 	epostgres --start 65432
# 	distutils-r1_src_test
# 	epostgres --stop
# }
# @CODE

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI} unsupported."
esac

if [[ ! ${_DATABASES_ECLASS} ]]; then
_DATABASES_ECLASS=1

# @ECLASS_VARIABLE: DATABASES_REQ_USE
# @PRE_INHERIT
# @DEFAULT_UNSET
# @DESCRIPTION:
# Bash associative array of USE flags required to be enabled on database
# servers, formed as a USE-dependency string.
#
# Keys are helper function names without the "e" prefix.

# @ECLASS_VARIABLE: DATABASES_DEPEND
# @OUTPUT_VARIABLE
# @DESCRIPTION:
# This is an eclass-generated bash associative array of dependency strings for
# database servers.
#
# Keys are helper function names without the "e" prefix.
declare -Ag DATABASES_DEPEND=()

# @FUNCTION: _databases_set_globals
# @INTERNAL
# @DESCRIPTION:
# Set the DATABASES_DEPEND variable.
_databases_set_globals() {
	local -A db_pkgs=(
		[memcached]="net-misc/memcached"
		[mongod]="dev-db/mongodb"
		[mysql]="virtual/mysql"
		[postgres]="dev-db/postgresql"
		[redis]="dev-db/redis"
	)

	local -A db_useflags=(
		[mysql]="server"
		[postgres]="server"
	)

	if declare -p DATABASES_REQ_USE &>/dev/null; then
		[[ $(declare -p DATABASES_REQ_USE) == "declare -A"* ]] || \
			die "DATABASES_REQ_USE must be declared as an associative array"
	fi

	local name dep usestr
	for name in "${!db_pkgs[@]}"; do
		dep=${db_pkgs[${name}]?}
		usestr=${db_useflags[${name}]}
		usestr+=",${DATABASES_REQ_USE[${name}]}"
		# strip leading/trailing commas
		usestr=${usestr#,}
		usestr=${usestr%,}

		[[ ${usestr} ]] && usestr="[${usestr}]"
		DATABASES_DEPEND[${name?}]="${dep?}${usestr}"
	done

	readonly DATABASES_DEPEND
}
_databases_set_globals
unset -f _databases_set_globals

# ==============================================================================
# GENERIC FUNCTIONS
# ==============================================================================

# @FUNCTION: _databases_die
# @USAGE: <funcname> [msg]
# @INTERNAL
# @DESCRIPTION:
# Print the given message and the path to the server's log file to the console
# and die.
#
# This function supports being called via "nonfatal".
_databases_die() {
	local funcname=${1?}
	shift

	eerror "See the server log for details:"
	eerror "	$(${funcname} --get-logfile)"
	die -n "${@}"
}

# @FUNCTION: _databases_add_deps
# @USAGE: <funcname> <use>
# @INTERNAL
# @DESCRIPTION:
# Set the BDEPEND, IUSE and RESTRICT variables.
_databases_add_deps() {
	local funcname=${1?}
	local useflag=${2?}

	BDEPEND="${useflag}? ( ${DATABASES_DEPEND[${funcname:1}]} )"
	IUSE="${useflag}"
	[[ ${useflag} == "test" ]] &&
		RESTRICT="!test? ( test )"

	return 0
}

# @FUNCTION: _databases_stop_service
# @USAGE: <funcname>
# @INTERNAL
# @DESCRIPTION:
# Default function to stop servers.  Reads PID from a file and sends the TERM
# signal.
_databases_stop_service() {
	debug-print-function "${FUNCNAME}" "${@}"

	local funcname=${1?}
	local srvname=${funcname:1}
	local pidfile="$(${funcname} --get-pidfile)"

	ebegin "Stopping ${srvname}"
	kill "$(<"${pidfile}")"
	eend $? || ${funcname} --die "Stopping ${srvname} failed"
}

# @FUNCTION: _databases_dispatch
# @USAGE: <funcname> <cmd> [args...]
# @INTERNAL
# @DESCRIPTION:
# Process the given command with its options.
#
# If "--start" command is used, "_${funcname}_start" function must be defined.
# Note that directories will be created automatically.
#
# If "_${funcname}_stop" function is not declared, the internal
# `_databases_stop_service` function will be used instead.
#
# "--get-*" and "-add-deps" helpers cannot be overloaded.
_databases_dispatch() {
	local funcname=${1?}
	local cmd=${2?}
	shift; shift

	case ${cmd} in
		--add-deps)
			_databases_add_deps ${funcname} "${@}"
			;;
		--die)
			_databases_die ${funcname} "${@}"
			;;
		--get-dbpath)
			echo "${T}"/${funcname}/db/
			;;
		--get-logfile)
			echo "${T}"/${funcname}/${funcname}.log
			;;
		--get-pidfile)
			echo "${T}"/${funcname}/${funcname}.pid
			;;
		--get-sockdir)
			echo "${T}"/${funcname}/
			;;
		--get-sockfile)
			echo "${T}"/${funcname}/${funcname}.sock
			;;
		--start)
			local port=${1}
			local start_fn=( _${funcname}_start ${port} )
			if ! declare -f "${start_fn[0]}" >/dev/null; then
				die "${ECLASS}: function not declared: ${start_fn[0]}"
			fi

			mkdir -p "${T}"/${funcname}/db/ || die "Creating database directory failed"
			"${start_fn[@]}"
			;;
		--stop)
			local stop_fn=( _${funcname}_stop )
			if ! declare -f "${stop_fn[0]}" >/dev/null; then
				# fall back to the default implementation
				stop_fn=( _databases_stop_service ${funcname} )
			fi

			"${stop_fn[@]}"
			;;
		*) die "${funcname}: invalid command: ${cmd}" ;;
	esac
}

# ==============================================================================
# MEMCACHED
# ==============================================================================

# @FUNCTION: _ememcached_start
# @USAGE: [port]
# @INTERNAL
# @DESCRIPTION:
# Start memcached server.
_ememcached_start() {
	debug-print-function "${FUNCNAME}" "${@}"

	local port=${1:-11211}

	local myargs=(
		--daemon
		--port=${port}
		--user=nobody
		--listen=127.0.0.1
		--pidfile=$(ememcached --get-pidfile)
	)

	ebegin "Spawning memcached"
	memcached "${myargs[@]}" &>> $(ememcached --get-logfile)
	eend $? || ememcached --die "Spawning memcached failed"
}

# @FUNCTION: ememcached
# @USAGE: <cmd> [args...]
# @DESCRIPTION:
# Manage memcached server on the given port (default: 11211).
ememcached() {
	_databases_dispatch "${FUNCNAME}" "${@}"
}

# ==============================================================================
# MONGODB
# ==============================================================================

# @FUNCTION: _emongod_start
# @USAGE: [port]
# @INTERNAL
# @DESCRIPTION:
# Start MongoDB server.
_emongod_start() {
	debug-print-function "${FUNCNAME}" "${@}"

	local port=${1:-27017}
	local logfile=$(emongod --get-logfile)

	local myargs=(
		--dbpath="$(emongod --get-dbpath)"
		--nojournal
		--bind-ip=127.0.0.1
		--port=${port}
		--unixSocketPrefix="$(emongod --get-sockdir)"
		--logpath="${logfile}"
		--fork
	)

	ebegin "Spawning mongodb"
	LC_ALL=C mongod "${myargs[@]}" &>> "${logfile}"
	eend $? || emongod --die "Spawning mongod failed"
}

# @FUNCTION: _emongod_stop
# @INTERNAL
# @DESCRIPTION:
# Stop MongoDB server.
_emongod_stop() {
	debug-print-function "${FUNCNAME}" "${@}"

	local myargs=(
		--dbpath="$(emongod --get-dbpath)"
		--shutdown
	)

	ebegin "Stopping mongodb"
	mongod "${myargs[@]}" &>> "${logfile}"
	eend $? || emongod --die "Stopping mongod failed"
}

# @FUNCTION: emongod
# @USAGE: <cmd> [args...]
# @DESCRIPTION:
# Manage MongoDB server on the given port (default: 27017).
emongod() {
	_databases_dispatch "${FUNCNAME}" "${@}"
}

# ==============================================================================
# MYSQL
# ==============================================================================

# @FUNCTION: _emysql_start
# @USAGE: [port]
# @INTERNAL
# @DESCRIPTION:
# Create a new MySQL database and start MySQL server.
_emysql_start() {
	debug-print-function "${FUNCNAME}" "${@}"

	local port=${1:-3306}
	local dbpath=$(emysql --get-dbpath)
	local logfile=$(emysql --get-logfile)
	local sockfile=$(emysql --get-sockfile)

	local myinstallargs=(
		--no-defaults
		--auth-root-authentication-method=normal
		--basedir="${BROOT}/usr"
		--datadir="${dbpath}"
	)

	ebegin "Initializing mysql database"
	mysql_install_db "${myinstallargs[@]}" &>> "${logfile}"
	eend $? || emysql --die "Initializing mysql database failed"

	local myargs=(
		--no-defaults
		--character-set-server=utf8
		--pid-file="$(emysql --get-pidfile)"
		--socket="${sockfile}"
		--bind-address=127.0.0.1
		--port=${port}
		--datadir="${dbpath}"
		--general-log-file="${logfile}"
		--log-error="${logfile}"
	)

	einfo "Spawning mysql"
	mysqld "${myargs[@]}" &>> "${logfile}" &

	einfo "Waiting for mysqld to accept connections"
	local timeout=30
	while ! mysqladmin ping --socket="${sockfile}" --silent; do
		sleep 1
		let timeout-=1
		[[ ${timeout} -eq 0 ]] && emysql --die "Timed out"
	done
}

# @FUNCTION: emysql
# @USAGE: <cmd> [args...]
# @DESCRIPTION:
# Manage MySQL server on the given port (default: 3306).
emysql() {
	_databases_dispatch "${FUNCNAME}" "${@}"
}

# ==============================================================================
# POSTGRESQL
# ==============================================================================

# @FUNCTION: _epostgres_start
# @USAGE: [port]
# @INTERNAL
# @DESCRIPTION:
# Create a new PostgreSQL database and start PostgreSQL server.
_epostgres_start() {
	debug-print-function "${FUNCNAME}" "${@}"

	local port=${1:-5432}
	local dbpath=$(epostgres --get-dbpath)
	local logfile=$(epostgres --get-logfile)

	local myinstallargs=(
		--pgdata="${dbpath}"
		--user=postgres
	)

	ebegin "Initializing postgresql database"
	initdb "${myinstallargs[@]}" &>> "${logfile}"
	eend $? || epostgres --die "Initializing postgresql database failed"

	local myargs=(
		--pgdata="${dbpath}"
		--log="${logfile}"
		--options="-h '127.0.0.1' -p ${port} -k '$(epostgres --get-sockdir)'"
		--wait
	)

	ebegin "Spawning postgresql"
	pg_ctl "${myargs[@]}" start &>> "${logfile}"
	eend $? || epostgres --die "Spawning postgresql failed"
}

# @FUNCTION: _epostgres_stop
# @INTERNAL
# @DESCRIPTION:
# Stop PosgreSQL server.
_epostgres_stop() {
	debug-print-function "${FUNCNAME}" "${@}"

	local myargs=(
		--pgdata="$(epostgres --get-dbpath)"
		--wait
	)

	ebegin "Stopping postgresql"
	pg_ctl "${myargs[@]}" stop &>> "$(epostgres --get-logfile)"
	eend $? || epostgres --die "Stopping postgresql failed"
}

# @FUNCTION: epostgres
# @USAGE: <cmd> [args...]
# @DESCRIPTION:
# Manage PostgreSQL server on the given port (default: 5432).
epostgres() {
	_databases_dispatch "${FUNCNAME}" "${@}"
}

# ==============================================================================
# REDIS
# ==============================================================================

# @FUNCTION: _eredis_start
# @USAGE: [args...]
# @INTERNAL
# @DESCRIPTION:
# Start Redis server.
_eredis_start() {
	debug-print-function "${FUNCNAME}" "${@}"

	local port=${1:-6379}
	local logfile="$(eredis --get-logfile)"

	ebegin "Spawning redis"
	redis-server - <<- EOF &>> "${logfile}"
		daemonize yes
		pidfile "$(eredis --get-pidfile)"
		port ${port}
		bind 127.0.0.1
		unixsocket "$(eredis --get-sockfile)"
		dir "$(eredis --get-dbpath)"
		logfile "${logfile}"
	EOF
	eend $? || eredis --die "Spawning redis failed"
}

# @FUNCTION: eredis
# @USAGE: <cmd> [args...]
# @DESCRIPTION:
# Manage Redis server on the given port (default: 6379).
eredis() {
	_databases_dispatch "${FUNCNAME}" "${@}"
}

fi
