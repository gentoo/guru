# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for media-video/owncast"
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( ${PN} )
ACCT_USER_HOME=/var/lib/owncast
ACCT_USER_HOME_PERMS=0755

acct-user_add_deps
