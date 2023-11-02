# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYPN="mlterm"
MYP="${MYPN}-${PV}"

DESCRIPTION="canna plugin for mlterm"
HOMEPAGE="https://mlterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${MYPN}/${MYP}.tar.gz"
S="${WORKDIR}/${MYP}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cairo fbcon wayland X xft"

DEPEND="
	app-i18n/canna
	cairo? ( x11-libs/cairo[X(+)] )
	wayland? (
		dev-libs/wayland
		x11-libs/libxkbcommon
	)
	X? (
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
	)
	xft? ( x11-libs/libXft )
"
RDEPEND="
	${DEPEND}
	~x11-terms/mlterm-${PV}[cairo=,fbcon=,wayland=,X=,xft=]
"

REQUIRED_USE="|| ( X fbcon wayland )"

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
		--with-gui=$(usex X "xlib" "")$(usex fbcon ",fb" "")$(usex wayland ",wayland" "")
		--with-type-engines=xcore$(usex xft ",xft" "")$(usex cairo ",cairo" "")
		--without-gtk
		--without-utmp

		$(use_with X x)
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
	popd || die
	pushd gui/fb/inputmethod/canna/ || die
	emake
	popd || die

	if use wayland; then
		pushd gui/wayland/inputmethod/canna/ || die
		emake
		popd || die
	fi
}

src_test() {
	:
}

src_install() {
	pushd inputmethod/canna || die
	DESTDIR="${D}" emake install
	popd || die
	pushd gui/fb/inputmethod/canna/ || die
	DESTDIR="${D}" emake install
	popd || die

	if use wayland; then
		pushd gui/wayland/inputmethod/canna/ || die
		DESTDIR="${D}" emake install
		popd || die
	fi

	find "${ED}" -name '*.la' -delete || die
}
