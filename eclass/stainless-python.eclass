# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: stainless-python.eclass
# @MAINTAINER:
# Florian Albrechtskirchinger <falbrechtskirchinger@gmail.com>
# @AUTHOR:
# Florian Albrechtskirchinger <falbrechtskirchinger@gmail.com>
# @SUPPORTED_EAPIS: 8 9
# @BLURB: Handle Python SDKs generated via Stainless.
# @DESCRIPTION:
# The stainless-python eclass manages the building and testing of Python SDKs
# generated via Stainless.
# It automates fetching the OpenAPI spec, provisioning the steady mock server
# from local npm packages, and managing the background mock server process
# lifecycle during tests.

case ${EAPI} in
	8|9) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ ! ${_STAINLESS_PYTHON_ECLASS} ]]; then
_STAINLESS_PYTHON_ECLASS=1

inherit distutils-r1

# @ECLASS_VARIABLE: STAINLESS_SPEC_BASE_URI
# @PRE_INHERIT
# @DESCRIPTION:
# The base URI for Stainless SDK OpenAPI spec files.
: "${STAINLESS_SPEC_BASE_URI:=https://storage.googleapis.com/stainless-sdk-openapi-specs}"

# @ECLASS_VARIABLE: STAINLESS_SPEC_PATH
# @PRE_INHERIT
# @DEFAULT_UNSET
# @REQUIRED
# @DESCRIPTION:
# The path of the OpenAPI spec file relative to ${STAINLESS_SPEC_BASE_URI}.

# @ECLASS_VARIABLE: STAINLESS_SPEC_DISTNAME
# @PRE_INHERIT
# @DESCRIPTION:
# The target filename of the OpenAPI spec file in ${DISTDIR}.
: "${STAINLESS_SPEC_DISTNAME:=${PN}-openapi-spec-${PV}.yml}"

# @ECLASS_VARIABLE: STAINLESS_MOCK_SERVER_VERSION
# @PRE_INHERIT
# @DEFAULT_UNSET
# @REQUIRED
# @DESCRIPTION:
# The version string of the mock server.

# @ECLASS_VARIABLE: STAINLESS_MOCK_SERVER_PACKAGE_JSON
# @PRE_INHERIT
# @DEFAULT_UNSET
# @REQUIRED
# @DESCRIPTION:
# The full path to the mock server package.json.

# @ECLASS_VARIABLE: STAINLESS_MOCK_SERVER_PACKAGE_LOCK_JSON
# @PRE_INHERIT
# @DESCRIPTION:
# The full path to the mock server package-lock.json.
: "${STAINLESS_MOCK_SERVER_PACKAGE_LOCK_JSON:=${STAINLESS_MOCK_SERVER_PACKAGE_JSON%.json}-lock.json}"

# @ECLASS_VARIABLE: STAINLESS_MOCK_SERVER_PORT
# @DESCRIPTION:
# The requested port for the mock server. 0 to bind to a random available port.
: "${STAINLESS_MOCK_SERVER_PORT:=0}"

# @ECLASS_VARIABLE: STAINLESS_MOCK_SERVER_EXTRA_ARGS
# @DESCRIPTION:
# Additional arguments to pass to the mock server.
STAINLESS_MOCK_SERVER_EXTRA_ARGS=()

# @ECLASS_VARIABLE: STAINLESS_MOCK_SERVER_DISTFILES
# @INTERNAL
# @DESCRIPTION:
# The array of npm packages for the mock server.
STAINLESS_MOCK_SERVER_DISTFILES=()

# @ECLASS_VARIABLE: STAINLESS_MOCK_SERVER_DIR
# @INTERNAL
# @DESCRIPTION:
# The full path to the mock server directory.
: "${STAINLESS_MOCK_SERVER_DIR:=${WORKDIR}/stainless-mock-server}"

# @ECLASS_VARIABLE: STAINLESS_MOCK_SERVER_EXEC
# @INTERNAL
# @DESCRIPTION:
# The full path to the mock server executable.
: "${STAINLESS_MOCK_SERVER_EXEC:=${STAINLESS_MOCK_SERVER_DIR}/node_modules/.bin/steady}"

# @ECLASS_VARIABLE: STAINLESS_MOCK_SERVER_PID
# @INTERNAL
# @DESCRIPTION:
# The PID assigned to the mock server.

# @ECLASS_VARIABLE: STAINLESS_MOCK_SERVER_PORT_ACTUAL
# @INTERNAL
# @DESCRIPTION:
# The port the mock server actually bound to.

_stainless_set_globals() {
	[[ -n ${STAINLESS_SPEC_PATH} ]] ||
		die "STAINLESS_SPEC_PATH undefined."
	[[ -n ${STAINLESS_MOCK_SERVER_VERSION} ]] ||
		die "STAINLESS_MOCK_SERVER_VERSION undefined."
	[[ -n ${STAINLESS_MOCK_SERVER_PACKAGE_JSON} ]] ||
		die "STAINLESS_MOCK_SERVER_PACKAGE_JSON undefined."

	local stdy_base_uri="https://registry.npmjs.org/@stdy"
	local stdy_pv="${STAINLESS_MOCK_SERVER_VERSION}"

	SRC_URI="
		test? (
			${STAINLESS_SPEC_BASE_URI}/${STAINLESS_SPEC_PATH}
				-> ${STAINLESS_SPEC_DISTNAME}

			${stdy_base_uri}/cli/-/cli-${stdy_pv}.tgz
				-> stdy-cli-${stdy_pv}.npm.tgz

			amd64? (
				${stdy_base_uri}/cli-linux-x64/-/cli-linux-x64-${stdy_pv}.tgz
					-> stdy-cli-linux-x64-${stdy_pv}.npm.tgz
			)

			arm64? (
				${stdy_base_uri}/cli-linux-arm64/-/cli-linux-arm64-${stdy_pv}.tgz
					-> stdy-cli-linux-arm64-${stdy_pv}.npm.tgz
			)
		)
	"

	STAINLESS_MOCK_SERVER_DISTFILES=(
		"stdy-cli-${stdy_pv}.npm.tgz"
		"stdy-cli-linux-x64-${stdy_pv}.npm.tgz"
		"stdy-cli-linux-arm64-${stdy_pv}.npm.tgz"
	)
	readonly STAINLESS_MOCK_SERVER_DISTFILES

	BDEPEND="
		test? (
			net-libs/nodejs[npm]
			net-misc/curl
			sys-apps/iproute2
		)
	"
}
_stainless_set_globals
unset -f _stainless_set_globals

# @FUNCTION: stainless_setup_mock_server
# @USAGE:
# @DESCRIPTION:
# Prepare the mock server by populating the npm cache and installing the npm
# packages.
stainless_setup_mock_server() {
	einfo "Populating npm cache ..."

	local -x npm_config_offline="true"
	local -x npm_config_audit="false"
	local -x npm_config_fund="false"
	local -x npm_config_cache="${WORKDIR}/stainless-npm-cache"
	mkdir -p "${npm_config_cache}" || die

	local f
	for f in "${STAINLESS_MOCK_SERVER_DISTFILES[@]}"; do
		[[ -e ${DISTDIR}/${f} ]] || continue
		if ! npm cache add "${DISTDIR}/${f}" &>"${T}/stainless-npm-cache-add.log"; then
			eerror "npm cache add '${f}' failed:"
			cat "${T}/stainless-npm-cache-add.log"
			die "npm cache add '${f}' failed"
		fi
	done

	einfo "Installing mock server ..."

	mkdir -p "${STAINLESS_MOCK_SERVER_DIR}" || die

	cp "${STAINLESS_MOCK_SERVER_PACKAGE_JSON}" \
		"${STAINLESS_MOCK_SERVER_DIR}/package.json" || die
	cp "${STAINLESS_MOCK_SERVER_PACKAGE_LOCK_JSON}" \
		"${STAINLESS_MOCK_SERVER_DIR}/package-lock.json" || die

	pushd "${STAINLESS_MOCK_SERVER_DIR}" >/dev/null || die
	if ! npm ci &>"${T}/stainless-npm-ci.log"; then
		eerror "npm ci failed:"
		cat "${T}/stainless-npm-ci.log"
		die "npm ci failed"
	fi
	popd >/dev/null || die

	[[ -x ${STAINLESS_MOCK_SERVER_EXEC} ]] || die
}

# @FUNCTION: _stainless_read_cmdline
# @USAGE: <pid|'self'> <out_var_name>
# @INTERNAL
# @DESCRIPTION:
# Read /proc/<pid|'self'>/cmdline into the provided array variable.
_stainless_read_cmdline() {
	(( ${#} == 2 )) || die "Usage: ${FUNCNAME} <pid|'self'> <out_var_name>"

	local pid="${1}"
	local -n out_var="${2}"

	readarray -d '' out_var <"/proc/${pid}/cmdline" 2>/dev/null || die
}

# @FUNCTION: _stainless_is_mock_server_running
# @USAGE:
# @INTERNAL
# @DESCRIPTION:
# Check if the mock server is running.
_stainless_is_mock_server_running() {
	[[ -n ${STAINLESS_MOCK_SERVER_PID} ]] || die

	kill -0 "${STAINLESS_MOCK_SERVER_PID}" 2>/dev/null || return 1

	local -a args
	_stainless_read_cmdline "${STAINLESS_MOCK_SERVER_PID}" args

	# Check args[1] (native) or args[2] (QEMU user-mode emulation)
	[[ ${args[1]} == "${STAINLESS_MOCK_SERVER_EXEC}" ||
		${args[2]} == "${STAINLESS_MOCK_SERVER_EXEC}" ]]
}

# @FUNCTION: _stainless_mock_server_health_check
# @USAGE:
# @INTERNAL
# @DESCRIPTION:
# Call the mock server health check endpoint.
_stainless_mock_server_health_check() {
	local base_url="http://127.0.0.1:${STAINLESS_MOCK_SERVER_PORT_ACTUAL}"

	# omit '|| die'; caller checks exit code
	curl -sf "${base_url}/_x-steady/health" &>/dev/null
}

# @FUNCTION: _stainless_wait_for_mock_server
# @USAGE:
# @INTERNAL
# @DESCRIPTION:
# Wait for the mock server to start.
_stainless_wait_for_mock_server() {
	[[ -n ${STAINLESS_MOCK_SERVER_PID} ]] || die

	local -a self_args mock_args
	_stainless_read_cmdline self self_args

	# 30s timeout (300 attempts with 0.1s waits)
	local attempts=0 ready=0
	while (( attempts < 300 )); do
		# We can arrive here between fork() & execve()
		# Wait for Bash to spawn the mock server
		if [[ -n ${mock_args[*]} && ${self_args[*]} != "${mock_args[*]}" ]]; then
			if ! _stainless_is_mock_server_running; then
				eerror "Mock server exited during startup:"
				cat "${T}/stainless-steady.log"
				die "Mock server exited during startup"
			fi

			# Discover actual port
			if [[ -z ${STAINLESS_MOCK_SERVER_PORT_ACTUAL} ]]; then
				if (( STAINLESS_MOCK_SERVER_PORT == 0 )); then
					local -a pids
					readarray -t pids \
						< <(pgrep -P "${STAINLESS_MOCK_SERVER_PID}" 2>/dev/null)

					if (( ${#pids[@]} > 1 )); then
						die "Mock server unexpectedly spawned multiple child processes"
					elif (( ${#pids[@]} == 1 )); then
						local port
						port=$(ss -Hntlp 2>/dev/null | awk -v pid="${pids[0]}" \
							'$0 ~ "pid="pid"," {split($4, a, ":"); print a[length(a)]}')
						if [[ -n ${port} ]]; then
							STAINLESS_MOCK_SERVER_PORT_ACTUAL=${port}
						fi
					fi
				else
					STAINLESS_MOCK_SERVER_PORT_ACTUAL=${STAINLESS_MOCK_SERVER_PORT}
				fi
			fi

			# Confirm startup by connecting to health check endpoint
			if [[ -n ${STAINLESS_MOCK_SERVER_PORT_ACTUAL} ]]; then
				if _stainless_mock_server_health_check; then
					ready=1
					break
				fi
			fi
		fi

		(( attempts++ ))
		sleep 0.1

		_stainless_read_cmdline "${STAINLESS_MOCK_SERVER_PID}" mock_args
	done

	if (( ! ready )); then
		# Note: Possible sign of failed port discovery
		eerror "Timed out waiting for mock server to start:"
		cat "${T}/stainless-steady.log"
		die "Timed out waiting for mock server to start"
	fi
}

# @FUNCTION: stainless_start_mock_server
# @USAGE:
# @DESCRIPTION:
# Start the mock server and wait for it to become ready.
stainless_start_mock_server() {
	if (( STAINLESS_MOCK_SERVER_PORT != 0 )); then
		if _stainless_mock_server_health_check; then
			die "Mock server address already in use"
		fi
	fi

	einfo "Starting mock server ..."

	# Replicate the logic from scripts/mock --daemon
	"${STAINLESS_MOCK_SERVER_EXEC}" \
		--host 127.0.0.1 -p "${STAINLESS_MOCK_SERVER_PORT}" \
		--validator-form-array-format=brackets \
		--validator-query-array-format=brackets \
		--validator-form-object-format=brackets \
		--validator-query-object-format=brackets \
		"${STAINLESS_MOCK_SERVER_EXTRA_ARGS[@]}" \
		"${DISTDIR}/${STAINLESS_SPEC_DISTNAME}" &>"${T}/stainless-steady.log" &
	STAINLESS_MOCK_SERVER_PID=${!}

	_stainless_wait_for_mock_server

	einfo "Mock server ready"
}

# @FUNCTION: stainless_stop_mock_server
# @USAGE:
# @DESCRIPTION:
# Stop the mock server.
stainless_stop_mock_server() {
	[[ -n ${STAINLESS_MOCK_SERVER_PID} ]] || die

	if _stainless_is_mock_server_running; then
		einfo "Stopping mock server ..."
		kill "${STAINLESS_MOCK_SERVER_PID}" || die
		wait "${STAINLESS_MOCK_SERVER_PID}" 2>/dev/null
	fi
}

# @FUNCTION: stainless-python_pkg_setup
# @DESCRIPTION:
# Abort if testing is enabled on an architecture unsupported by the mock server.
stainless-python_pkg_setup() {
	if use test && ! { use amd64 || use arm64; }; then
		die "Tests are only supported on amd64 and arm64"
	fi
}

# @FUNCTION: stainless-python_src_unpack
# @USAGE:
# @DESCRIPTION:
# Implement unpacking of dist files, skipping the mock server npm packages,
# and run deferred validation of the mock server version.
stainless-python_src_unpack() {
	# Validate mock server version:
	# Ensure STAINLESS_MOCK_SERVER_VERSION matches package.json
	local json expected_pv
	json=$(<"${STAINLESS_MOCK_SERVER_PACKAGE_JSON}") || die

	[[ ${json} =~ \"@stdy/cli\"[[:space:]]*:[[:space:]]*\"([^\"]+)\" ]] &&
		expected_pv=${BASH_REMATCH[1]}

	[[ -n ${expected_pv} ]] ||
		die "Expected '@stdy/cli' dependency declaration in package.json"

	[[ ${STAINLESS_MOCK_SERVER_VERSION} == "${expected_pv}" ]] ||
		die "Mock server version mismatch:" \
			"'${STAINLESS_MOCK_SERVER_VERSION}' (from var) !=" \
			"'${expected_pv}' (from package.json)"

	local f
	for f in ${A}; do
		! has "${f}" "${STAINLESS_MOCK_SERVER_DISTFILES[@]}" && unpack "${f}"
	done
}

# @FUNCTION: stainless-python_src_test
# @USAGE:
# @DESCRIPTION:
# Implement the mock server setup, startup, test run, and shutdown logic.
stainless-python_src_test() {
	stainless_setup_mock_server

	stainless_start_mock_server

	local -x TEST_API_BASE_URL="http://127.0.0.1:${STAINLESS_MOCK_SERVER_PORT_ACTUAL}"
	nonfatal distutils-r1_src_test
	local ret=${?}

	stainless_stop_mock_server

	(( ret == 0 )) || die
}

# @FUNCTION: _stainless_death_cleanup
# @USAGE:
# @INTERNAL
# @DESCRIPTION:
# Death hook function to gracefully stop a running mock server during abnormal
# test termination.
_stainless_death_cleanup() {
	[[ -n ${STAINLESS_MOCK_SERVER_PID} ]] || return 0

	kill "${STAINLESS_MOCK_SERVER_PID}" 2>/dev/null
	wait "${STAINLESS_MOCK_SERVER_PID}" 2>/dev/null
}

has _stainless_death_cleanup "${EBUILD_DEATH_HOOKS}" ||
	EBUILD_DEATH_HOOKS+=" _stainless_death_cleanup"

EXPORT_FUNCTIONS pkg_setup src_unpack src_test

fi
