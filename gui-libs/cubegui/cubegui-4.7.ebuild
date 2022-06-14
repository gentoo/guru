# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools bash-completion-r1 qmake-utils

DESCRIPTION="CUBE Uniform Behavioral Encoding GUI"
HOMEPAGE="https://www.scalasca.org/scalasca/software/cube-4.x"
SRC_URI="https://apps.fz-juelich.de/scalasca/releases/cube/${PV}/dist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="concurrent debug scorep webengine"

RDEPEND="
	concurrent? ( dev-qt/qtconcurrent:5 )
	scorep? ( sys-cluster/scorep )
	webengine? ( dev-qt/qtwebengine:5 )

	dev-libs/cubelib
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5
	sys-apps/dbus
	sys-libs/zlib
"
DEPEND="${RDEPEND}"
BDEPEND="app-doc/doxygen[dot]"

PATCHES=( "${FILESDIR}/${P}-autotroll.patch" )

src_prepare() {
	default
	pushd build-frontend || die
	eautoreconf
	popd || die
	eautoreconf
}

src_configure() {
	export CC=gcc
	export CXX=g++
	export QT_LIBS="-lQt5PrintSupport -lQt5Widgets -lQt5Gui -lQt5Network -lQt5Core"
	use concurrent && export QT_LIBS="${QT_LIBS} -lQt5Concurrent"
	use webengine && export QT_LIBS="${QT_LIBS} -lQt5WebEngineWidgets"

	local myconf=(
		--disable-platform-mic
		--with-cubelib="${EPREFIX}/usr"
		--with-plugin-advancedcolormaps
		--with-plugin-barplot
		--with-plugin-cube-diff
		--with-plugin-cube-mean
		--with-plugin-cube-merge
		--with-plugin-heatmap
		--with-plugin-launch
		--with-plugin-metric-identify
		--with-plugin-metriceditor
		--with-plugin-source
		--with-plugin-statistics
		--with-plugin-paraver
		--with-plugin-sunburst
		--with-plugin-system-statistics
		--with-plugin-system-topology
		--with-plugin-treeitem-marker
		--with-plugin-vampir
		--with-qt="$(qt5_get_bindir)"

		$(use_enable debug)
		$(use_with concurrent)
		$(use_with scorep plugin-scorep-config)
		$(use_with webengine web-engine)
	)
	if use scorep; then
		myconf+=( "--with-scorep=${EPREFIX}/usr" )
	else
		myconf+=( "--without-scorep" )
	fi

	econf "${myconf[@]}" CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" CPPFLAGS="${CPPFLAGS}" LDFLAGS="${LDFLAGS}" "${myconf[@]}"
}

src_install() {
	MAKEOPTS="-j1" default
	mkdir -p "${ED}/usr/share/doc/${PF}/html"
	mv "${ED}/usr/share/doc/${PF}/guide/html" "${ED}/usr/share/doc/${PF}/html/guide" || die
	mv "${ED}/usr/share/doc/${PF}/plugins-guide/html" "${ED}/usr/share/doc/${PF}/html/plugins-guide" || die
	rm -rf "${ED}/usr/share/doc/${PF}/guide" || die
	rm -rf "${ED}/usr/share/doc/${PF}/plugins-guide" || die
	docompress -x "/usr/share/doc/${PF}/html"
	mv "${ED}/usr/share/doc/cubegui/example" "${ED}/usr/share/doc/${PF}/examples" || die
	docompress -x "/usr/share/doc/${PF}/examples"
	rm -rf "${ED}/usr/share/doc/cubegui" || die

	newbashcomp "${ED}/usr/bin/cubegui-autocompletion.sh" cubegui
	rm -r "${ED}/usr/bin/cubegui-autocompletion.sh" || die

	find "${ED}" -name '*.a' -delete || die
	find "${ED}" -name '*.la' -delete || die
}
