# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit cmake desktop xdg fortran-2

DESCRIPTION="Open-source Modelica-based modeling and simulation environment"
HOMEPAGE="https://openmodelica.org/"

declare -A commit
commit[OpenModelica]="38bef66da59e57597a6a5f482695e6c37ca09940"
commit[OMCompiler-3rdParty]="05b2332389883ff2a6021ecdf2e13d5a00ebf286"
# See line 10 in OMCompiler/Compiler/boot/CMakeLists.txt
commit[OMBootstrapping]="04d16f7461e5401321f0f72613daf466ae2f76be"
commit[OMSens]="093ad1134cf572ea73a9c7f834614e53ba5ea878"
commit[OMSens_Qt]="bab329ae897ce28621dc45a34cc9cc7dad1aa002"
commit[OMSimulator]="86e9635bda23ffc87a33c90bfbbc6ee7192cbb7a"
commit[OMSimulator-3rdParty]="4ee9733a8fa6de86ce6fc18d775de4efbd7aae9f"
commit[OMOptim]="f1036f43db18c5015da259771004cfb80e08a110"
commit[OpenModelica-common]="6e6d4fd78c74da79ef079ee412d5325eb3b60166"

SRC_URI="
	https://github.com/OpenModelica/OpenModelica/archive/${commit[OpenModelica]}.tar.gz
		-> ${P}.tar.gz
	https://github.com/OpenModelica/OMCompiler-3rdParty/archive/${commit[OMCompiler-3rdParty]}.tar.gz
		-> OMCompiler-3rdParty_${P}.tar.gz
	https://github.com/OpenModelica/OMBootstrapping/archive/${commit[OMBootstrapping]}.tar.gz
		-> OMBootstrapping_${P}.tar.gz
	https://github.com/OpenModelica/OMSens/archive/${commit[OMSens]}.tar.gz
		-> OMSens_${P}.tar.gz
	https://github.com/OpenModelica/OMSens_Qt/archive/${commit[OMSens_Qt]}.tar.gz
		-> OMSens_Qt_${P}.tar.gz
	https://github.com/OpenModelica/OMSimulator/archive/${commit[OMSimulator]}.tar.gz
		-> OMSimulator_${P}.tar.gz
	https://github.com/OpenModelica/OMSimulator-3rdParty/archive/${commit[OMSimulator-3rdParty]}.tar.gz
		-> OMSimulator-3rdParty_${P}.tar.gz
	https://github.com/OpenModelica/OMOptim/archive/${commit[OMOptim]}.tar.gz
		-> OMOptim_${P}.tar.gz
	https://github.com/OpenModelica/OpenModelica-common/archive/${commit[OpenModelica-common]}.tar.gz
		-> OpenModelica-common_${P}.tar.gz

"

LICENSE="OSMC-PL GPL-3 AGPL-3 BSD EPL-1.0 public-domain BSD-with-attribution LGPL-2.1+ LGPL-2 Apache-2.0 Boost-1.0 Modelica-1.1 Modelica-2 MIT WTFPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs"
REQUIRED_USE="|| ( static-libs )"

RDEPEND="
	>=app-text/asciidoc-10.2.1
	>=app-text/doxygen-1.13.2
	>=dev-libs/boost-1.88.0-r1
	>=dev-games/openscenegraph-3.6.5-r118
	dev-lang/python:3.12
	>=dev-libs/expat-2.7.3
	>=dev-libs/icu-77.1
	>=dev-libs/libxml2-2.14.6
	>=dev-python/kiwisolver-1.4.9
	>=dev-python/matplotlib-3.10.3
	>=dev-python/numpy-2.3.1
	>=dev-python/pandas-2.3.0
	>=dev-python/pillow-11.3.0
	>=dev-python/pytest-8.4.2
	>=dev-python/six-1.17.0
	>=dev-python/sphinx-8.2.3-r2
	dev-qt/qt5compat:6
	dev-qt/qtbase:6
	dev-qt/qtdeclarative:6
	dev-qt/qtpositioning:6
	dev-qt/qtsvg:6
	dev-qt/qtwebchannel:6
	dev-qt/qtwebengine:6
	>=net-misc/curl-8.16.0-r1
	>=net-misc/omniORB-4.3.0
	>=sci-libs/hdf5-1.14.6-r2
	>=sys-apps/hwloc-2.11.2-r1
	>=sys-devel/flex-2.6.4-r6
	>=sys-libs/ncurses-6.4_p20240414
	>=sys-libs/readline-8.3_p1
	>=virtual/blas-3.8
	>=virtual/jdk-17
	>=virtual/lapack-3.10
	>=virtual/libiconv-0-r2
	>=virtual/libintl-0-r2
	>=virtual/opencl-3-r5
	>=virtual/opengl-8
	>=virtual/pkgconfig-3
"

BDEPEND="
	dev-util/ccache
	>=media-gfx/imagemagick-7.1.1.25-r1[png]
"

DEPEND="${RDEPEND}"

src_unpack() {
	default

	mv "${WORKDIR}/OpenModelica-${commit[OpenModelica]}" "${S}" || die
	rmdir "${S}/OMCompiler/3rdParty" || die
	mv "${WORKDIR}/OMCompiler-3rdParty-${commit[OMCompiler-3rdParty]}" "${S}/OMCompiler/3rdParty" || die
	rmdir "${S}/OMSens" || die

	# OMOptim depends on a working CORBA interface (which fails to compile) supplied by OmniORB.
	# For compilation trials remember setting -DOM_OMC_USE_CORBA=ON.
	#rmdir "${S}/OMOptim" || die
	#mv "${WORKDIR}/OMOptim-${commit[OMOptim]}" "${S}/OMOptim" || die
	#rmdir "${S}/OMOptim/common" || die
	#cp -a "${WORKDIR}/OpenModelica-common-${commit[OpenModelica-common]}" "${S}/OMOptim/common" || die

	mv "${WORKDIR}/OMSens-${commit[OMSens]}" "${S}/OMSens" || die
	rmdir "${S}/OMSens_Qt" || die
	mv "${WORKDIR}/OMSens_Qt-${commit[OMSens_Qt]}" "${S}/OMSens_Qt" || die
	rmdir "${S}/OMSens_Qt/common" || die
	mv "${WORKDIR}/OpenModelica-common-${commit[OpenModelica-common]}" "${S}/OMSens_Qt/common" || die
	rmdir "${S}/OMSimulator" || die
	mv "${WORKDIR}/OMSimulator-${commit[OMSimulator]}" "${S}/OMSimulator" || die
	rmdir "${S}/OMSimulator/3rdParty" || die
	mv "${WORKDIR}/OMSimulator-3rdParty-${commit[OMSimulator-3rdParty]}" "${S}/OMSimulator/3rdParty" || die
	mv "OMBootstrapping-${commit[OMBootstrapping]}" "${S}/OMCompiler/Compiler/boot/bomc" || die
	touch "${S}/OMCompiler/Compiler/boot/bomc/sources.tar.gz" || die

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
		-DOM_QT_MAJOR_VERSION=6
	)
	cmake_src_configure
}

src_compile() {
	# [2024-07-15]
	# OMSens is disabled in "${S}/CMakeLists.txt" (## omc_add_subdirectory(OMSens)) due to lack of a
	# working "${S}/OMSens/CMakeLists.txt". So, we compile it manually.
	pushd OMSens/fortran_interface > /dev/null || die
	${FC} -fPIC -c Rutf.for Rut.for Curvif.for || die
	# BUG: Undefined symbol curvif_ in
	# ${S}/OMSens/fortran_interface/curvif_simplified.cpython-312-x86_64-linux-gnu.so
	# See with nm -D or objdump -tT
	# ${S}/OMSens/fortran_interface/curvif_simplified.cpython-312-x86_64-linux-gnu.so
	# This bug causes "Vectorial Parameter Based Sensitivity Analysis" in OMSens to fail.
	f2py --verbose -c -I. Curvif.o Rutf.o Rut.o -m curvif_simplified curvif_simplified.pyf Curvif_simplified.f90 || die
	popd > /dev/null || die

	cmake_src_compile
}

src_install() {
	cmake_src_install

	# [2024-07-15]
	# OMSens is disabled in "${S}/CMakeLists.txt" (## omc_add_subdirectory(OMSens)) due to lack of a
	# working "${S}/OMSens/CMakeLists.txt". So, we install it manually.
	cp -a "${WORKDIR}"/"${P}"/OMSens "${ED}"/usr/share/ || die
	rm -fr "${ED}"/usr/share/OMSens/{old,.git,.gitignore,CMakeLists.txt,.jenkins,Jenkinsfile,Makefile.omdev.mingw,Makefile.unix} || die
	rm -fr "${ED}"/usr/share/OMSens/{README.md,setup.py,testing} || die

	newicon -s scalable OMShell/OMShell/OMShellGUI/Resources/omshell-large.svg omshell.svg
	newicon -s scalable OMNotebook/OMNotebook/OMNotebookGUI/Resources/OMNotebook_icon.svg OMNotebook.svg
	magick convert OMEdit/OMEditLIB/Resources/icons/omedit.ico[0] -thumbnail 256x256 -flatten \
		OMEdit/OMEditLIB/Resources/icons/omedit_icon.png || die
	newicon -s 256 OMEdit/OMEditLIB/Resources/icons/omedit_icon.png omedit.png

	make_desktop_entry "OMEdit %F" OMedit omedit "Physics;" "MimeType=text/x-modelica;"
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
	rm -fr "${ED}"/usr/doc  "${ED}"/usr/share/{zmq,cmake,cminpack} "${ED}"/tmp || die

	ewarn "Upstream has deprecated OMTLMSimulator and, therefore, it has not been installed. Use OMSimulator/SSP instead."
}
