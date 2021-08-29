# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for FORT RPKI validator"
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( fort )
ACCT_USER_HOME="/usr/share/${PN}/"

acct-user_add_deps
