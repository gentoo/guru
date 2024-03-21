# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

HOMEPAGE="https://github.com/erebe/greenclip"
DESCRIPTION="Simple clipboard manager to be integrated with rofi"

MY_PN=${PN%-bin}
SRC_URI="
	https://github.com/erebe/${MY_PN}/releases/download/v${PV}/${MY_PN} -> ${P}
	https://raw.githubusercontent.com/erebe/${MY_PN}/v${PV}/README.md -> ${P}.README.md
"

KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="0"

QA_PREBUILT="/usr/bin/${MY_PN}"
S="${WORKDIR}"

src_install() {
	newbin "${DISTDIR}/${P}" "${MY_PN}"
	newdoc "${DISTDIR}/${P}.README.md" README.md
}

pkg_postinst() {
	elog "Please read /usr/share/doc/${PF}/README.md.bz2"
	elog "on how to use rofi/dmenu/fzf as a menu for the clipboard."
}
