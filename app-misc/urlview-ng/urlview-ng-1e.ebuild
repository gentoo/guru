# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit toolchain-funcs

DESCRIPTION="Extract URLs from text"
HOMEPAGE="https://sr.ht/~nabijaczleweli/urlview-ng/"
SRC_URI="https://git.sr.ht/~nabijaczleweli/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="0BSD GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-libs/ncurses:="
RDEPEND="${DEPEND}"
BDEPEND="
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	default

	sed "/ADD_L/s/ -O3.*$//" -i Makefile || die
}

src_configure() {
	tc-export CC CXX

	export VERSION="${PV}"
	export PREFIX="${EPREFIX}/usr"
	export CURSESCONF="pkg-config ncursesw"
	export SYSTEM_INITFILE="${EPREFIX}/etc/urlview.conf"
	export MANUAL_DATE="October  6, 2024"

	# disable running shellcheck and xgettext
	export SHELLCHECK="@#"
	export NOLOCREGEN="@#"
}
