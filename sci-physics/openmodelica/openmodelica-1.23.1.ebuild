# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit cmake git-r3 desktop xdg

DESCRIPTION="Open-source Modelica-based modeling and simulation environment"
HOMEPAGE="https://openmodelica.org/"

EGIT_REPO_URI="https://github.com/OpenModelica/OpenModelica.git"
EGIT_COMMIT="v1.23.1"

LICENSE="OSMC-PL GPL-3 AGPL-3 BSD EPL-1.0 public-domain BSD-with-attribution LGPL-2.1+ LGPL-2 Apache-2.0 Boost-1.0 Modelica-1.1 Modelica-2 MIT WTFPL-2"
SLOT="0"
# KEYWORDS="~amd64"

RDEPEND="
	>=virtual/lapack-3.10
	>=dev-libs/boost-1.84.0-r3
	>=virtual/opencl-3-r3
	>=net-misc/curl-8.7.1-r4
	>=sys-libs/readline-8.2_p10
	>=app-text/asciidoc-10.2.0
	>=virtual/libintl-0-r2
	>=virtual/libiconv-0-r2
	>=virtual/blas-3.8
	>=virtual/lapack-3.10
	>=virtual/jdk-17
	>=virtual/pkgconfig-3
	dev-qt/qtconcurrent:5
	dev-qt/qtprintsupport:5
	dev-qt/qtxml:5
	dev-qt/qtopengl:5
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5
	dev-qt/qtwebengine:5[widgets]
	dev-qt/qtxmlpatterns:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtdeclarative:5
	dev-qt/qtquickcontrols:5
	dev-qt/qtquickcontrols2:5
	dev-qt/qtwebchannel:5[qml]
	dev-qt/qtpositioning:5[qml]
	>=dev-games/openscenegraph-3.6.5-r114
	>=virtual/opengl-7.0-r2
	>=dev-libs/expat-2.5.0
	>=net-misc/omniORB-4.3.0
	>=dev-python/six-1.16.0-r1
	>=dev-python/pytest-8.2.2
	>=dev-python/numpy-1.26.4
	>=dev-python/matplotlib-3.3
	>=dev-python/kiwisolver-1.3.2
	>=dev-python/pillow-9.0.1
	>=dev-python/pandas-1.1.3
	dev-lang/python:3.12
"

# dev-libs/libxml2 only needed if compiled with -DOM_OMEDIT_ENABLE_LIBXML2=ON
RDEPEND+="
	>=dev-libs/libxml2-2.12.7
	>=dev-libs/icu-74.2
	>=app-text/doxygen-1.9.8
	>=dev-python/sphinx-7.3.7-r2
	>=sys-devel/flex-2.6.4-r6
	>=sys-apps/hwloc-2.9.2
	>=sci-libs/hdf5-1.14.3-r1
	>=sys-libs/ncurses-6.4_p20240414
"

BDEPEND="
	dev-util/ccache
	net-misc/wget
	app-arch/tar
	virtual/fortran
"

DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/"${P}"-raw_strings.patch
)

BOMCCOMMIT="c289e97c41d00939a4a69fe504961b47283a6d8e"
TMPBOMCARCHIVE="${T}/sources-${BOMCCOMMIT}.tar.gz"

pkg_setup() {
	# OMCompiler/Compiler/boot/CMakeLists.txt downloads a file during src_prepare phase which is blocked by ebuild
	# network sandbox. Upstream downloads the (changing) master archive by default. Instead, the specific commit
	# available at this OpenModelica version release date is taken.
	local URI="https://github.com/OpenModelica/OMBootstrapping/archive/${BOMCCOMMIT}.tar.gz"

	[[ -f "${DISTFILE}" ]] || wget "${URI}" -O "${TMPBOMCARCHIVE}"

	local SHA12SUM=$(sha512sum "${TMPBOMCARCHIVE}")
	einfo "${SHA12SUM}"
	[[ "${SHA12SUM}" == "2202f02edc33ac4fb7264b0ea82ae4b2c965a85f8b96cb872cc4cc59c5e5b76346a023c416f994a9744021428d598c3dbdf688c0845ba4726849d3c9ee0cd4ba  ${TMPBOMCARCHIVE}" ]] || die "Wrong checksum."
	local B2SUM=$(b2sum "${TMPBOMCARCHIVE}")
	einfo "${B2SUM}"
	[[ "${B2SUM}" == "afdda81842a686e092b46bd50d192f5e35ae6c662e8c5517346d86c7c098f2e23a99df27bc5c045b819472d0539837c845c63123ae4822127a14ac42e4ad2e97  ${TMPBOMCARCHIVE}" ]] || die "Wrong checksum."
}

src_prepare() {
	# Setup Bootstrapping OMC
	local BOMCDIR="${WORKDIR}"/"${P}"/OMCompiler/Compiler/boot/bomc
	mkdir -p "${BOMCDIR}"
	mv "${TMPBOMCARCHIVE}" "${BOMCDIR}"/sources.tar.gz
	tar xzf "${BOMCDIR}"/sources.tar.gz --strip-components=1 -C "${BOMCDIR}"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DOM_OMEDIT_ENABLE_QTWEBENGINE=ON
		-DBUILD_SHARED_LIBS=OFF
		-DOM_ENABLE_ENCRYPTION=OFF
		-DOM_USE_CCACHE=ON
		-DOM_ENABLE_GUI_CLIENTS=ON
		-DOM_OMC_ENABLE_FORTRAN=ON
		-DOM_OMC_ENABLE_IPOPT=ON
		-DOM_OMC_ENABLE_CPP_RUNTIME=ON
		-DOM_OMC_USE_CORBA=OFF
		-DOM_OMC_USE_LAPACK=ON
		-DOM_OMEDIT_INSTALL_RUNTIME_DLLS=ON
		-DOM_OMEDIT_ENABLE_TESTS=OFF
		-DOM_OMEDIT_ENABLE_QTWEBENGINE=ON
		-DOM_OMEDIT_ENABLE_LIBXML2=ON
	)
	cmake_src_configure
}

src_compile() {
	# [2024-07-15]
	# OMSens is disabled in "${WORKDIR}/${P}/CMakeLists.txt" (## omc_add_subdirectory(OMSens)) due to lack of a
	# working "${WORKDIR}/${P}/OMSens/CMakeLists.txt". So, we compile it manually.
	PWD=$(pwd)
	cd "${WORKDIR}"/"${P}"/OMSens/fortran_interface
	gfortran -fPIC -c Rutf.for Rut.for Curvif.for
	# BUG: Undefined symbol curvif_ in
	# ${WORKDIR}/${P}/OMSens/fortran_interface/curvif_simplified.cpython-312-x86_64-linux-gnu.so
	# This bug causes "Vectorial Parameter Based Sensitivity Analysis" in OMSens to fail.
	f2py --verbose -c -I. Curvif.o Rutf.o Rut.o -m curvif_simplified curvif_simplified.pyf Curvif_simplified.f90
	cd "${PWD}"

	cmake_src_compile
}

src_install() {
	cmake_src_install

	# [2024-07-15]
	# OMSens is disabled in "${WORKDIR}/${P}/CMakeLists.txt" (## omc_add_subdirectory(OMSens)) due to lack of a
	# working "${WORKDIR}/${P}/OMSens/CMakeLists.txt". So, we install it manually.
	cp -a "${WORKDIR}"/"${P}"/OMSens "${ED}"/usr/share/
	rm -fr "${ED}"/usr/share/OMSens/{old,.git,.gitignore,CMakeLists.txt,.jenkins,Jenkinsfile,Makefile.omdev.mingw,Makefile.unix,README.md,setup.py,testing}

	newicon -s scalable OMShell/OMShell/OMShellGUI/Resources/omshell-large.svg omshell.svg
	newicon -s scalable OMNotebook/OMNotebook/OMNotebookGUI/Resources/OMNotebook_icon.svg OMNotebook.svg
	# No proper icon for Linux available from upstream
	doicon -s 256 "${FILESDIR}"/omedit.png
	make_desktop_entry "OMEdit %F" OMedit omedit "Physics;" "MimeType=text/x-modelica;"
	make_desktop_entry OMShell OMShell omshell "Physics;"
	make_desktop_entry "OMNotebook %f" OMNotebook OMNotebook "Physics;"

	# Fix libraries
	if [[ $(get_libdir) != "lib" ]]; then
		mv "${ED}"/usr/lib/omc/* "${ED}"/usr/$(get_libdir)/omc/
		rmdir "${ED}"/usr/lib/omc/
		dosym -r /usr/$(get_libdir)/omc /usr/lib/omc
	fi
	dosym -r /usr/include/omc/ParModelica /usr/include/ParModelica

	# Documentation housekeeping & QA
	mv "${ED}"/usr/share/doc/omc "${ED}"/usr/share/doc/"${P}"
	rm -fr "${ED}"/usr/doc

	ewarn "Upstream has deprecated OMTLMSimuulator and, therefore, it has not been installed. Use OMSimulator/SSP instead."
}
