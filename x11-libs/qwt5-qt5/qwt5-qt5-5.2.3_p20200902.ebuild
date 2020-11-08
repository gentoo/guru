# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

COMMIT="0052f96fdd6d5f021f20a1cfc4d2fcfc605941da"

DESCRIPTION="2D plotting library for Qt5"
HOMEPAGE="https://qwt.sourceforge.io/ https://github.com/gbm19/qwt5-qt5"
SRC_URI="https://github.com/gbm19/qwt5-qt5/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="qwt"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
SLOT="5"
IUSE="doc examples svg"

RDEPEND="
	dev-qt/designer:5
	dev-qt/qtgui:5
	svg? ( dev-qt/qtsvg:5 )
"
BDEPEND="doc? ( app-doc/doxygen )"

DOCS=( CHANGES README )

S="${WORKDIR}/${PN}-${COMMIT}"

src_prepare() {
	default
	sed -e "/QwtVersion/s:5.2.2.:${PV}:g" -i qwt.prf || die

	cat > qwtconfig.pri <<-EOF
		target.path = "${EPREFIX}/usr/$(get_libdir)"
		headers.path = "${EPREFIX}/usr/include/qwt5"
		doc.path = "${EPREFIX}/usr/share/doc/${PF}"
		CONFIG += qt warn_on thread release
		CONFIG += QwtDll QwtPlot QwtWidgets QwtDesigner
		VERSION = ${PV}
		QWT_VERSION = ${PV/_*}
		QWT_INSTALL_PLUGINS   = "${EPREFIX}/usr/$(get_libdir)/qt5/plugins/designer"
		QWT_INSTALL_FEATURES  = "${EPREFIX}/usr/share/qt5/mkspecs/features"
	EOF
	sed -i -e 's/headers doc/headers/' src/src.pro || die
	use svg && echo >> qwtconfig.pri "CONFIG += QwtSVGItem"
}

src_configure() {
	eqmake5
}

src_compile() {
	default
	if use doc ; then
		cd doc || die
		doxygen Doxyfile || die "doxygen failed"
		HTML_DOCS="doc/html"
	fi
}

src_install () {
	emake INSTALL_ROOT="${D}" install
	einstalldocs
	doman doc/man/*/*

	if use examples; then
		# don't build examples - fix the qt files to build once installed
		cat > examples/examples.pri <<-EOF
			include( qwtconfig.pri )
			TEMPLATE     = app
			MOC_DIR      = moc
			INCLUDEPATH += "${EPREFIX}/usr/include/qwt5"
			DEPENDPATH  += "${EPREFIX}/usr/include/qwt5"
			LIBS        += -lqwt
		EOF
		sed -i -e 's:../qwtconfig:qwtconfig:' examples/examples.pro || die
		cp *.pri examples/ || die
		insinto /usr/share/qwt5
		doins -r examples
	fi

	# avoid file conflict with qwt:6
	# https://github.com/gbm19/qwt5-qt5/issues/2
	pushd "${ED}/usr/share/man/man3/"
	for f in *; do mv ${f} ${f//.3/.5qt5.3}; done
	popd
}
