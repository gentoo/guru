# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Authy/Google Authenticator like TOTP CLI tool written in Go"
HOMEPAGE="https://github.com/yitsushi/totp-cli"
SRC_URI="https://github.com/yitsushi/totp-cli/releases/download/v$PV/totp-cli_Linux_x86_64.tar.gz"

S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"

QA_PREBUILT="usr/bin/$PN"

src_install() {
	newbin totp-cli ${PN}
}

pkg_postinst() {
	einfo "For a more mature TOTP you can try app-admin/keepassxc, cli included"
}
