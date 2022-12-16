# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nim-utils

DESCRIPTION="A Nim build system"
HOMEPAGE="
	https://nimbus.sysrq.in/
	https://git.sysrq.in/nimbus/about/
"
SRC_URI="https://git.sysrq.in/${PN}/snapshot/${P}.tar.bz2"

LICENSE="Apache-2.0 BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-lang/nim"
BDEPEND="${RDEPEND}"

src_configure() {
	nim_gen_config
}

src_compile() {
	enim c src/${PN}
}

src_test() {
	etestament all
}

src_install() {
	dobin src/${PN}

	doman ${PN}.1
	einstalldocs
}
