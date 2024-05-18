# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN=${PN%-bin}

DESCRIPTION="Simple clipboard manager to be integrated with rofi"
HOMEPAGE="https://github.com/erebe/greenclip"
SRC_URI="
	https://github.com/erebe/${MY_PN}/releases/download/v${PV}/${MY_PN} -> ${P}
	https://raw.githubusercontent.com/erebe/${MY_PN}/v${PV}/README.md -> ${P}.README.md
"

S="${WORKDIR}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

QA_PREBUILT="/usr/bin/${MY_PN}"

src_install() {
	newbin "${DISTDIR}/${P}" "${MY_PN}"
	newdoc "${DISTDIR}/${P}.README.md" README.md
}

pkg_postinst() {
	elog "Please read /usr/share/doc/${PF}/README.md.bz2"
	elog "on how to use rofi/dmenu/fzf as a menu for the clipboard."
}
