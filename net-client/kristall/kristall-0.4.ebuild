# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo out-of-source qmake-utils xdg

DESCRIPTION="Visual cross-platform gemini browser"
HOMEPAGE="https://github.com/MasterQ32/kristall"

if [ "${PV}" == "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/MasterQ32/${PN}.git"
else
	SRC_URI="https://github.com/MasterQ32/${PN}/archive/V${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	app-text/cmark:=
	dev-libs/gumbo
	dev-libs/openssl:=
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5[widgets]
	dev-qt/qtnetwork:5[ssl]
	dev-qt/qtwidgets:5
	media-libs/libglvnd
"
DEPEND="${RDEPEND}
	dev-qt/qtsvg:5
"
BDEPEND="dev-qt/linguist-tools:5"

src_prepare() {
	default

	sed 's/$(shell cd $$PWD; git describe --tags)/'${PV}'/' \
		-i src/kristall.pro || die
}

my_src_configure() {
	eqmake5 "${S}"/src/kristall.pro CONFIG+="external-cmark external-gumbo-parser"
}

my_src_compile() {
	emake
	cp kristall "${S}" || die
}

src_compile() {
	out-of-source_src_compile

	cd doc || die
	edo sh gen-man.sh
}

src_install() {
	emake -o kristall DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	einstalldocs
}
