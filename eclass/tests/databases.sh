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

einfo "Testing dependency strings"
eindent
test_depend
eoutdent

texit
