# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit python-single-r1 qmake-utils xdg

DESCRIPTION="Application for Scientific Data Analysis and Visualization"
HOMEPAGE="http://scidavis.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/SciDAVis/$(ver_cut 1)/$(ver_cut 1-2)/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"

IUSE="assistant doc origin python test"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-cpp/muParser
	dev-qt/qtgui:5
	dev-qt/qtopengl:5
	sci-libs/gsl
	sys-libs/zlib[minizip]
	x11-libs/qwt5-qt5:5
	x11-libs/qwtplot3d
	assistant? ( dev-qt/assistant )
	origin? ( sci-libs/liborigin )
	python? (
		${PYTHON_DEPS}
		$(python_gen_cond_dep '
		dev-python/PyQt5[${PYTHON_USEDEP}]
		dev-python/PyQt5-sip[${PYTHON_USEDEP}]
		dev-python/sip[${PYTHON_USEDEP}]
		')
	)
"
BDEPEND="
	doc? ( app-doc/doxygen )
	test? ( dev-libs/unittest++ )
"

PATCHES=(
	"${FILESDIR}/${PN}-build.patch"
	"${FILESDIR}/${PN}-tests.patch"
)

src_prepare() {
	default

	# OF has been renamed in Gentoo https://bugs.gentoo.org/383179
	# Note this is *not* packaged in sys-libs/zlib[minizip] because
	# this file resides in the test directory in upstream zlib
	sed -i -r 's:\<(O[FN])\>:_Z_\1:g' 3rdparty/minigzip/minigzip.c || die

	# fix paths
	cat >> config.pri <<-EOF
		# install docs to ${PF} instead of ${PN}
		documentation.path = "\$\$INSTALLBASE/share/doc/${PF}"

		# install python files in Gentoo specific directories
		pythonconfig.path = "$(python_get_scriptdir)"
		pythonutils.path = "$(python_get_scriptdir)"

		# /usr/share/appdata is deprecated
		appdata.path = "\$\$INSTALLBASE/share/metainfo"
	EOF
}

src_configure() {
	INSTALLBASE="${EPREFIX}/usr" eqmake5 \
		$(usex assistant  " " " CONFIG+=noassistant ") \
		$(usex origin " CONFIG+=liborigin " " ") \
		$(usex python " CONFIG+=python " " ") \
		$(usex test " CONFIG+=test " " ")
}

src_compile() {
	default
	if use doc ; then
		doxygen Doxyfile || die "doxygen failed"
		HTML_DOCS="API/html"
	fi
}

src_install () {
	emake INSTALL_ROOT="${D}" install || die "install failed"
	einstalldocs
	use python && python_optimize
}
