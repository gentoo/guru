# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="A user for ollama"
ACCT_USER_ID=999
ACCT_USER_SHELL=/bin/false
ACCT_USER_HOME=/var/share/ollama
ACCT_USER_HOME_PERMS=0755
ACCT_USER_GROUPS=( ollama )

acct-user_add_deps
