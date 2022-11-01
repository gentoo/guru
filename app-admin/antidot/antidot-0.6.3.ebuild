# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Cleans up your \$HOME from those pesky dotfiles"
HOMEPAGE="https://github.com/doron-cohen/antidot"
SRC_URI="https://github.com/doron-cohen/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="MIT Apache-2.0 BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

src_compile() {
	ego build -v -x -work -o ${PN}
}

src_install() {
	dobin ${PN}
	einstalldocs
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog "To get started with antidot, first run 'antidot update'"
		elog "Then add the output of 'antidot init' to your .bash_profile or similar"
	fi
}
