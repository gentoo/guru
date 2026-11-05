# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

DESCRIPTION="Authy/Google Authenticator like TOTP CLI tool written in Go"
HOMEPAGE="https://github.com/yitsushi/totp-cli"
SRC_URI="
	amd64? (
		https://github.com/yitsushi/totp-cli/releases/download/v${PV}/totp-cli_Linux_x86_64.tar.gz
		-> ${P}-amd64.tar.gz
	)
	arm64? (
		https://github.com/yitsushi/totp-cli/releases/download/v${PV}/totp-cli_Linux_arm64.tar.gz
		-> ${P}-arm64.tar.gz
	)
	x86? (
		https://github.com/yitsushi/totp-cli/releases/download/v${PV}/totp-cli_Linux_i386.tar.gz
		-> ${P}-x86.tar.gz
	)
"


LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
RESTRICT="strip"
S="${WORKDIR}"
DOCS=( README.md )

QA_PREBUILT="usr/bin/${PN}"

src_install() {
	newbin totp-cli "${PN}"
	einstalldocs
}

pkg_postinst() {
	einfo "For a more mature TOTP you can try app-admin/keepassxc, cli included"
}
