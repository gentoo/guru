# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for Maubot Matrix Integrations"

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( maubot )
ACCT_USER_HOME=/var/lib/maubot
ACCT_USER_HOME_PERMS=0750

acct-user_add_deps
