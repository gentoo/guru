# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

DESCRIPTION="3D plotting library for Qt5"
HOMEPAGE="http://qwtplot3d.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="ZLIB"
KEYWORDS="~amd64 ~x86"
SLOT="0"

IUSE="doc examples"

RDEPEND="
	dev-qt/qtgui:5
	dev-qt/qtopengl:5
	x11-libs/gl2ps
"
BDEPEND="doc? ( app-doc/doxygen )"

S="${WORKDIR}/${PN}"

PATCHES=(
	"${FILESDIR}/${PN}-profile.patch"
	"${FILESDIR}/${PN}-examples.patch"
	"${FILESDIR}/${PN}-doxygen.patch"
	"${FILESDIR}/${PN}-gcc44.patch"
	"${FILESDIR}/${PN}-qt-4.8.0.patch"
)

src_prepare() {
	default
	eapply -p0 "${FILESDIR}/${PN}-sys-gl2ps.patch"
	cat >> ${PN}.pro <<-EOF
		target.path = "${EPREFIX}/usr/$(get_libdir)"
		headers.path = "${EPREFIX}/usr/include/${PN}"
		headers.files = \$\$HEADERS
		INSTALLS = target headers
	EOF
}

src_configure() {
	eqmake5
}

src_compile() {
	default
	if use doc ; then
		cd doc || die
		doxygen Doxyfile.doxygen || die "doxygen failed"
		HTML_DOCS="doc/web/doxygen/"
	fi
}

src_install () {
	emake INSTALL_ROOT="${D}" install || die "install failed"
	einstalldocs
	if use examples; then
		insinto /usr/share/${PN}
		doins -r examples
	fi
}
