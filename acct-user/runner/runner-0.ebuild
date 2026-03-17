# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="Forgejo-Runner user account"

IUSE="docker podman lxc"

ACCT_USER_HOME=/var/lib/runner
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( runner )

acct-user_add_deps

BDEPEND+="
	docker? ( acct-group/docker )
	podman? ( acct-group/docker )
	lxc? ( acct-group/lxc )
"

pkg_setup() {
	if use docker || use podman; then
		ACCT_USER_GROUPS+=( docker )
	fi

	if use lxc; then
		ACCT_USER_GROUPS+=( lxc )
	fi
}

