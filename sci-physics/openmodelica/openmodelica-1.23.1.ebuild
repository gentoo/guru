# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit cmake desktop xdg

DESCRIPTION="Open-source Modelica-based modeling and simulation environment"
HOMEPAGE="https://openmodelica.org/"
SRC_URI="
   https://github.com/OpenModelica/OpenModelica/archive/332e81aa6442c4cc4761251407332f86f80e834b.tar.gz -> ${P}.tar.gz
   https://github.com/OpenModelica/OMCompiler-3rdParty/archive/b826af1c1c15acf48627ad32cc0545ffc7e58bca.tar.gz -> OMCompiler-3rdParty_${P}.tar.gz
   https://github.com/OpenModelica/OMBootstrapping/archive/c289e97c41d00939a4a69fe504961b47283a6d8e.tar.gz -> OMBootstrapping_${P}.tar.gz
   https://github.com/OpenModelica/OMSens/archive/0d804d597bc385686856d453cc830fad4923fa3e.tar.gz -> OMSens_${P}.tar.gz
   https://github.com/OpenModelica/OMSens_Qt/archive/68b1b8697ac9f8e37ebe4de13c0c1d4e6e2e56fb.tar.gz -> OMSens_Qt_${P}.tar.gz
   https://github.com/OpenModelica/OpenModelica-common/archive/08a01802db5ba5edb540383c46718b89ff229ef2.tar.gz -> OpenModelica-common_${P}.tar.gz
   https://github.com/OpenModelica/OMSimulator/archive/1eb92ef35793b73e75d0cfed0c7b0311497d6278.tar.gz -> OMSimulator_${P}.tar.gz
   https://github.com/OpenModelica/OMSimulator-3rdParty/archive/ca418d7768c036ac15e9894d7f00d2118b3399a6.tar.gz -> OMSimulator-3rdParty_${P}.tar.gz
"

LICENSE="OSMC-PL GPL-3 AGPL-3 BSD EPL-1.0 public-domain BSD-with-attribution LGPL-2.1+ LGPL-2 Apache-2.0 Boost-1.0 Modelica-1.1 Modelica-2 MIT WTFPL-2"
SLOT="0"
KEYWORDS="~amd64"

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
	app-arch/tar
	virtual/fortran
"

DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/"${P}"-raw_strings.patch
)

src_unpack() {
	default

	mv "${WORKDIR}/OpenModelica-332e81aa6442c4cc4761251407332f86f80e834b" "${WORKDIR}/${P}" || die
	rmdir "${WORKDIR}/${P}/OMCompiler/3rdParty" || die
	mv "${WORKDIR}/OMCompiler-3rdParty-b826af1c1c15acf48627ad32cc0545ffc7e58bca" "${WORKDIR}/${P}/OMCompiler/3rdParty" || die
	rmdir "${WORKDIR}/${P}/OMSens" || die
	mv "${WORKDIR}/OMSens-0d804d597bc385686856d453cc830fad4923fa3e" "${WORKDIR}/${P}/OMSens" || die
	rmdir "${WORKDIR}/${P}/OMSens_Qt" || die
	mv "${WORKDIR}/OMSens_Qt-68b1b8697ac9f8e37ebe4de13c0c1d4e6e2e56fb" "${WORKDIR}/${P}/OMSens_Qt" || die
	rmdir "${WORKDIR}/${P}/OMSens_Qt/common" || die
	mv "${WORKDIR}/OpenModelica-common-08a01802db5ba5edb540383c46718b89ff229ef2" "${WORKDIR}/${P}/OMSens_Qt/common" || die
	rmdir "${WORKDIR}/${P}/OMSimulator" || die
	mv "${WORKDIR}/OMSimulator-1eb92ef35793b73e75d0cfed0c7b0311497d6278" "${WORKDIR}/${P}/OMSimulator" || die
	rmdir "${WORKDIR}/${P}/OMSimulator/3rdParty" || die
	mv "${WORKDIR}/OMSimulator-3rdParty-ca418d7768c036ac15e9894d7f00d2118b3399a6" "${WORKDIR}/${P}/OMSimulator/3rdParty" || die
	mv "OMBootstrapping-c289e97c41d00939a4a69fe504961b47283a6d8e" "${WORKDIR}/${P}/OMCompiler/Compiler/boot/bomc" || die
	touch "${WORKDIR}/${P}/OMCompiler/Compiler/boot/bomc/sources.tar.gz" || die
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
	pushd OMSens/fortran_interface > /dev/null || die
	gfortran -fPIC -c Rutf.for Rut.for Curvif.for || die
	# BUG: Undefined symbol curvif_ in
	# ${WORKDIR}/${P}/OMSens/fortran_interface/curvif_simplified.cpython-312-x86_64-linux-gnu.so
	# See with nm or objdump -tT
	# ${WORKDIR}/${P}/OMSens/fortran_interface/curvif_simplified.cpython-312-x86_64-linux-gnu.so
	# This bug causes "Vectorial Parameter Based Sensitivity Analysis" in OMSens to fail.
	f2py --verbose -c -I. Curvif.o Rutf.o Rut.o -m curvif_simplified curvif_simplified.pyf Curvif_simplified.f90 || die
	popd || die

	cmake_src_compile
}

src_install() {
	cmake_src_install

	# [2024-07-15]
	# OMSens is disabled in "${WORKDIR}/${P}/CMakeLists.txt" (## omc_add_subdirectory(OMSens)) due to lack of a
	# working "${WORKDIR}/${P}/OMSens/CMakeLists.txt". So, we install it manually.
	cp -a "${WORKDIR}"/"${P}"/OMSens "${ED}"/usr/share/ || die
	rm -fr "${ED}"/usr/share/OMSens/{old,.git,.gitignore,CMakeLists.txt,.jenkins,Jenkinsfile,Makefile.omdev.mingw,Makefile.unix,README.md,setup.py,testing} || die

	newicon -s scalable OMShell/OMShell/OMShellGUI/Resources/omshell-large.svg omshell.svg
	newicon -s scalable OMNotebook/OMNotebook/OMNotebookGUI/Resources/OMNotebook_icon.svg OMNotebook.svg
	# No proper icon for Linux available from upstream for OMEdit
	make_desktop_entry "OMEdit %F" OMedit "" "Physics;" "MimeType=text/x-modelica;"
	make_desktop_entry OMShell OMShell omshell "Physics;"
	make_desktop_entry "OMNotebook %f" OMNotebook OMNotebook "Physics;"

	# Fix libraries
	if [[ $(get_libdir) != "lib" ]]; then
		mv "${ED}"/usr/lib/omc/* "${ED}"/usr/$(get_libdir)/omc/ || die
		rmdir "${ED}"/usr/lib/omc/ || die
		dosym -r /usr/$(get_libdir)/omc /usr/lib/omc
	fi
	dosym -r /usr/include/omc/ParModelica /usr/include/ParModelica

	# Documentation housekeeping & QA
	mv "${ED}"/usr/share/doc/omc "${ED}"/usr/share/doc/"${PF}" || die
	rm -fr "${ED}"/usr/doc || die

	ewarn "Upstream has deprecated OMTLMSimuulator and, therefore, it has not been installed. Use OMSimulator/SSP instead."
}
