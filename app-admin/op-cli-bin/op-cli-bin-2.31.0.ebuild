# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="command line interface for the 1password password manager"
HOMEPAGE="https://1password.com/downloads/command-line/"
SITE="https://cache.agilebits.com/dist/1P/op2/pkg/v${PV}"
SRC_URI="
amd64? ( ${SITE}/op_linux_amd64_v${PV}.zip )
arm64? ( ${SITE}/op_linux_arm64_v${PV}.zip )
"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

BDEPEND="app-arch/unzip"
RDEPEND="acct-group/1password-cli"

QA_PREBUILT="usr/bin/op"
RESTRICT="bindist mirror"
S="${WORKDIR}"

src_install() {
  dobin op
}

pkg_postinst() {
  chgrp 1password-cli /usr/bin/op
  chmod g+s /usr/bin/op
}
