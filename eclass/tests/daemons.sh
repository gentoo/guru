#!/bin/bash
# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GENTOO_REPO=$(portageq get_repo_path / gentoo) || exit
source "${GENTOO_REPO:?}"/eclass/tests/tests-common.sh || exit
TESTS_ECLASS_SEARCH_PATHS+=( "${GENTOO_REPO:?}"/eclass )

declare -A DAEMONS_REQ_USE=(
	[ceph]="ssl"
	[postgresql]="xml"
)

inherit daemons

test_depend() {
	tbegin "if \${DAEMONS_DEPEND} is defined"
	declare -p DAEMONS_DEPEND &>/dev/null
	tend $?

	tbegin "if \${DAEMONS_DEPEND} contains Pifpaf"
	[[ "${DAEMONS_DEPEND[*]}" == *"dev-util/pifpaf"* ]]
	tend $?

	tbegin "\${DAEMONS_DEPEND[ceph]}"
	[[ "${DAEMONS_DEPEND[ceph]}" == *"sys-cluster/ceph[ssl]" ]]
	tend $?

	tbegin "\${DAEMONS_DEPEND[consul]}"
	[[ "${DAEMONS_DEPEND[consul]}" == *"app-admin/consul" ]]
	tend $?

	tbegin "\${DAEMONS_DEPEND[httpbin]}"
	[[ "${DAEMONS_DEPEND[httpbin]}" == *"dev-python/httpbin" ]]
	tend $?

	tbegin "\${DAEMONS_DEPEND[kafka]}"
	[[ "${DAEMONS_DEPEND[kafka]}" == *"net-misc/kafka-bin" ]]
	tend $?

	tbegin "\${DAEMONS_DEPEND[memcached]}"
	[[ "${DAEMONS_DEPEND[memcached]}" == *"net-misc/memcached" ]]
	tend $?

	tbegin "\${DAEMONS_DEPEND[mysql]}"
	[[ "${DAEMONS_DEPEND[mysql]}" == *"virtual/mysql[server]" ]]
	tend $?

	tbegin "\${DAEMONS_DEPEND[postgresql]}"
	[[ "${DAEMONS_DEPEND[postgresql]}" == *"dev-db/postgresql[server,xml]" ]]
	tend $?

	tbegin "\${DAEMONS_DEPEND[redis]}"
	[[ "${DAEMONS_DEPEND[redis]}" == *"dev-db/redis" ]]
	tend $?

	tbegin "\${DAEMONS_DEPEND[vault]}"
	[[ "${DAEMONS_DEPEND[vault]}" == *"app-admin/vault" ]]
	tend $?
}

test_daemons_enable() {
	local IUSE= RESTRICT= BDEPEND=
	local svc=${1?}

	IUSE= RESTRICT= BDEPEND=
	tbegin "'daemons_enable ${svc} test'"
	daemons_enable ${svc} test && [[ ${BDEPEND} && ${IUSE} && ${RESTRICT} ]]
	tend $?

	IUSE= RESTRICT= BDEPEND=
	tbegin "'daemons_enable ${svc} test-db'"
	daemons_enable ${svc} test-db && [[ ${BDEPEND} && ${IUSE} && ! ${RESTRICT} ]]
	tend $?
}

einfo "Testing dependency strings"
eindent
test_depend
eoutdent

einfo "Testing daemons_enable"
eindent
for svc in "${!DAEMONS_DEPEND[@]}"; do
	test_daemons_enable ${svc}
done
eoutdent

texit
