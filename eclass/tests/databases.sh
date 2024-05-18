#!/bin/bash
# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GENTOO_REPO=$(portageq get_repo_path / gentoo) || exit
source "${GENTOO_REPO}"/eclass/tests/tests-common.sh || exit
TESTS_ECLASS_SEARCH_PATHS+=( "${GENTOO_REPO}"/eclass )

declare -A DATABASES_REQ_USE=(
	[mongod]="ssl"
	[postgres]="xml"
)

inherit databases

HELPERS=( ememcached emongod emysql epostgres eredis )

test_depend() {
	tbegin "if \${DATABASES_DEPEND} is defined"
	declare -p DATABASES_DEPEND &>/dev/null
	tend $?

	tbegin "\${DATABASES_DEPEND[memcached]}"
	test "${DATABASES_DEPEND[memcached]}" == "net-misc/memcached"
	tend $?

	tbegin "\${DATABASES_DEPEND[mongod]}"
	test "${DATABASES_DEPEND[mongod]}" == "dev-db/mongodb[ssl]"
	tend $?

	tbegin "\${DATABASES_DEPEND[mysql]}"
	test "${DATABASES_DEPEND[mysql]}" == "virtual/mysql[server]"
	tend $?

	tbegin "\${DATABASES_DEPEND[postgres]}"
	test "${DATABASES_DEPEND[postgres]}" == "dev-db/postgresql[server,xml]"
	tend $?

	tbegin "\${DATABASES_DEPEND[redis]}"
	test "${DATABASES_DEPEND[redis]}" == "dev-db/redis"
	tend $?
}

test_add_deps() {
	local IUSE= RESTRICT= BDEPEND=
	local helper=${1?}

	IUSE= RESTRICT= BDEPEND=
	tbegin "'${helper} --add-deps test'"
	${helper} --add-deps test && [[ ${BDEPEND} && ${IUSE} && ${RESTRICT} ]]
	tend $?

	IUSE= RESTRICT= BDEPEND=
	tbegin "'${helper} --add-deps test-db'"
	${helper} --add-deps test-db && [[ ${BDEPEND} && ${IUSE} && ! ${RESTRICT} ]]
	tend $?
}

test_getters() {
	local helper=${1?}
	local getters=(
		--get-dbpath
		--get-logfile
		--get-pidfile
		--get-sockdir
		--get-sockfile
	)

	for getter in "${getters[@]}"; do
		tbegin "'${helper} ${getter}'"
		test -n "$(${helper} ${getter})"
		tend $?
	done
}

einfo "Testing dependency strings"
eindent
test_depend
eoutdent

einfo "Testing --add-deps helper"
eindent
for helper in "${HELPERS[@]}"; do
	test_add_deps ${helper}
done
eoutdent

einfo "Testing --get-* helpers"
eindent
for helper in "${HELPERS[@]}"; do
	test_getters ${helper}
done
eoutdent

texit
