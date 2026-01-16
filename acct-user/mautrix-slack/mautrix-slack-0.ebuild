# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for Mautrix Slack Bridge"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~arm64-macos ~x64-macos ~x64-solaris"

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( mautrix )
ACCT_USER_HOME=/var/lib/mautrix/slack
ACCT_USER_HOME_PERMS=0750

acct-user_add_deps
