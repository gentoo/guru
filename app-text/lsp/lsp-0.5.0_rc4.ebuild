# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

MY_PV="${PV/_/-}"
MY_P="lsp-${MY_PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="The least significant pager"
HOMEPAGE="https://github.com/dgouders/lsp"
SRC_URI="https://github.com/dgouders/lsp/archive/refs/tags/v${MY_PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="
	>=sys-apps/man-db-2.12.0
	>=sys-libs/ncurses-6.4_p20230401
"
DEPEND="${RDEPEND}"

src_configure() {
	meson_src_configure
}

pkg_postinst() {
	elog "lsp(1) is still considered experimental."
	elog "Testers and feedback are very welcome!"
	elog ""
	elog "One known problem are files with long lines."
	elog "Movement within those files isn't accurate but"
	elog "this will get fixed in the near future."
	elog ""
	elog "To enable lsp(1) to be automatically selected"
	elog "as a pager, set either MANPAGER, GIT_PAGER and/or PAGER."
}
