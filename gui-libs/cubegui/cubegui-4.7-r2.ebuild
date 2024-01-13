# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 qmake-utils toolchain-funcs

MYPV="9a161bfd"
MYP="sources.${MYPV}"

DESCRIPTION="CUBE Uniform Behavioral Encoding GUI"
HOMEPAGE="https://www.scalasca.org/scalasca/software/cube-4.x"
SRC_URI="https://perftools.pages.jsc.fz-juelich.de/cicd/${PN}/branches/master/${MYP}.tar.gz -> ${P}-${MYPV}.tar.gz"
S="${WORKDIR}/${MYP}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="concurrent debug webengine"

RDEPEND="
	dev-libs/cubelib
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5
	sys-apps/dbus
	sys-libs/zlib
	concurrent? ( dev-qt/qtconcurrent:5 )
	webengine? ( dev-qt/qtwebengine:5 )
"
DEPEND="${RDEPEND}"
BDEPEND="app-text/doxygen[dot]"

# reconfigure needs custom autotools

src_configure() {
	tc-export CC CXX FC F77 CPP AR
	rm build-config/common/platforms/platform-* || die

	cat > build-config/common/platforms/platform-backend-user-provided <<-EOF || die
	CC=${CC}
	CXX=${CXX}
	FC=${FC}
	F77=${F77}
	CPP=${CPP}
	CXXCPP=${CPP}
	EOF

	cat > build-config/common/platforms/platform-frontend-user-provided <<-EOF || die
	CC_FOR_BUILD=${CC}
	F77_FOR_BUILD=${F77}
	FC_FOR_BUILD=${FC}
	CXX_FOR_BUILD=${CXX}
	LDFLAGS_FOR_BUILD=${LDFLAGS}
	CFLAGS_FOR_BUILD=${CFLAGS}
	CXXFLAGS_FOR_BUILD=${CXXFLAGS}
	CPPFLAGS_FOR_BUILD=${CPPFLAGS}
	FCFLAGS_FOR_BUILD=${FCFLAGS}
	FFLAGS_FOR_BUILD=${FFLAGS}
	EOF

	cat > build-config/common/platforms/platform-mpi-user-provided <<-EOF || die
	MPICC=mpicc
	MPICXX=mpicxx
	MPIF77=mpif77
	MPIFC=mpif90
	MPI_CPPFLAGS=${CPPFLAGS}
	MPI_CFLAGS=${CFLAGS}
	MPI_CXXFLAGS=${CXXFLAGS}
	MPI_FFLAGS=${FFLAGS}
	MPI_FCFLAGS=${FCFLAGS}
	MPI_LDFLAGS=${LDFLAGS}
	EOF

	local myconf=(
		--disable-platform-mic
		--with-cubelib="${EPREFIX}/usr"
		--with-custom-compilers
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
		--without-plugin-scorep-config
		--without-scorep
		--with-qt="$(qt5_get_bindir)"
		--with-qt-specs="$(qmake5 -query QMAKE_SPEC || die)"

		$(use_enable debug)
		$(use_with concurrent)
		$(use_with webengine web-engine)
	)

	econf "${myconf[@]}"
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
