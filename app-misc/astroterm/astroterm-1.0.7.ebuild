# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A planetarium for your terminal!"
HOMEPAGE="https://github.com/da-luce/astroterm"
SRC_URI="
	https://github.com/da-luce/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://web.archive.org/web/20231007085824if_/http://tdc-www.harvard.edu/catalogs/BSC5 -> bsc5
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/argtable
"

BDEPEND="
	|| ( dev-util/xxd app-editors/vim-core )
"

src_prepare() {
	default
	cp "${DISTDIR}/bsc5" "${S}/data" || die
	cp -r "${S}/scripts" "${WORKDIR}/scripts" || die
}

src_compile() {
	meson_src_compile
}

src_install() {
	meson_src_install
}
