# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="www-apps/gogs user"

ACCT_USER_ID=197 #Following git user; Change if there are conflicts
ACCT_USER_HOME_OWNER=gogs:git
ACCT_USER_HOME_PERMS=750
ACCT_USER_SHELL=/bin/bash
ACCT_USER_GROUPS=( git )
ACCT_USER_HOME=/var/lib/gogs
APP_DIR=/usr/share/gogs
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="app-shells/bash"

acct-user_add_deps
