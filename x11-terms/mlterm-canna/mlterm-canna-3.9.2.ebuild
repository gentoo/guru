# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYPN="mlterm"
MYP="${MYPN}-${PV}"

DESCRIPTION="canna plugin for mlterm"
HOMEPAGE="http://mlterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${MYPN}/${MYP}.tar.gz"
S="${WORKDIR}/${MYP}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="app-i18n/canna"
RDEPEND="
	${DEPEND}
	~x11-terms/mlterm-${PV}
"

src_configure() {
	local myconf=(
		--disable-brlapi
		--disable-debug
		--disable-fcitx
		--disable-fribidi
		--disable-ibus
		--disable-m17nlib
		--disable-nls
		--disable-optimize-redrawing
		--disable-otl
		--disable-scim
		--disable-skk
		--disable-ssh2
		--disable-static
		--disable-uim
		--disable-vt52
		--disable-wnn
		--enable-canna
		--with-gui=console
		--without-gtk
		--without-type-engines
		--without-utmp
		--without-x
	)

	addpredict /dev/ptmx
	econf "${myconf[@]}"
}

src_compile() {
	pushd baselib/src || die
	emake collect-headers libpobl.la
	popd || die
	pushd encodefilter/src || die
	emake collect-headers
	popd || die
	pushd inputmethod/canna || die
	emake
}

src_test() {
	:
}

src_install() {
	pushd inputmethod/canna || die
	DESTDIR="${D}" emake install
	find "${ED}" -name '*.la' -delete || die
}
