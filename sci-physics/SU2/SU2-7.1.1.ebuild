# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit meson python-single-r1

DESCRIPTION="SU2: An Open-Source Suite for Multiphysics Simulation and Design"
HOMEPAGE="https://su2code.github.io/"
SRC_URI="
	https://github.com/su2code/SU2/archive/v${PV}.tar.gz -> ${P}.tar.gz
	mpp? ( https://github.com/mutationpp/Mutationpp/archive/v1.0.1.tar.gz -> mutationpp-1.0.1.tar.gz )
	test? ( https://github.com/su2code/TestCases/archive/v${PV}.tar.gz -> ${P}-TestCases.tar.gz )
	tutorials? ( https://github.com/su2code/Tutorials/archive/v${PV}.tar.gz -> ${P}-Tutorials.tar.gz )
"

# SU2: LGPL-2.1; cgnslib: ZLIB, TecIO: all-rights-reserved;
# Metis: Apache-2.0; Parmetis: all-rights-reserved, free-noncomm; Mutationpp: LGPL-3.0.
LICENSE="Apache-2.0 LGPL-2.1 LGPL-3 ZLIB all-rights-reserved free-noncomm"
SLOT="0"
KEYWORDS="~amd64"

# cgns, metis, parmetis are bundled;
# omp is disable as it's experimental;
# pastix is disabled as it's try to find bundled libs;
IUSE="cgns mkl +mpi mpp openblas tecio test tutorials"
RESTRICT="!test? ( test )"
REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	mkl? ( !openblas )
"

RDEPEND="
	${PYTHON_DEPS}
	mpi? ( virtual/mpi[cxx] )
	mkl? ( sci-libs/mkl )
	openblas? ( sci-libs/openblas )
"
DEPEND="
	${RDEPEND}
	tecio? ( dev-libs/boost:= )
"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${PN}-7.0.4-unbundle_boost.patch"
	"${FILESDIR}/${PN}-7.1.0-fix-env.patch"
)

DOCS=( "README.md" "SU2_PY/documentation.txt" )

src_unpack() {
	unpack "${P}.tar.gz"
	if use mpp ; then
		einfo "Unpacking mutationpp-1.0.1.tar.gz to /var/tmp/portage/sci-physics/${P}/work/${P}/subprojects/Mutationpp"
		tar -C "${P}"/subprojects/Mutationpp --strip-components=1 -xzf "${DISTDIR}/mutationpp-1.0.1.tar.gz" || die
	fi
	if use test ; then
		einfo "Unpacking ${P}-TestCases.tar.gz to /var/tmp/portage/sci-physics/${P}/work/${P}/TestCases"
		tar -C "${P}"/TestCases --strip-components=1 -xzf "${DISTDIR}/${P}-TestCases.tar.gz" || die
	fi
	if use tutorials ; then
		einfo "Unpacking ${P}-Tutorials.tar.gz to /var/tmp/portage/sci-physics/${P}/work/${P}"
		mkdir "${P}"/Tutorials || die
		tar -C "${P}"/Tutorials --strip-components=1 -xzf "${DISTDIR}/${P}-Tutorials.tar.gz" || die
	fi
}

src_prepare(){
	default
	# boost Geometry requires c++14 since >=boost-1.75
	if has_version ">=dev-libs/boost-1.75.0" ; then
		sed -i -e 's:cpp_std=c++11:cpp_std=c++14:' meson.build || die
	fi
}

src_configure() {
	local emesonargs=(
		-Denable-autodiff=false
		-Denable-directdiff=false
		-Denable-pastix=false
		-Denable-pywrapper=false
		-Dwith-omp=false
		$(meson_feature mpi with-mpi)
		$(meson_use cgns enable-cgns)
		$(meson_use mkl enable-mkl)
		$(meson_use mpp enable-mpp)
		$(meson_use openblas enable-openblas)
		$(meson_use tecio enable-tecio)
		$(meson_use test enable-tests)
	)
	meson_src_configure
}

src_test() {
	ln -s ../../${P}-build/SU2_CFD/src/SU2_CFD SU2_PY/SU2_CFD || die
	ln -s ../../${P}-build/SU2_DEF/src/SU2_DEF SU2_PY/SU2_DEF || die
	ln -s ../../${P}-build/SU2_DOT/src/SU2_DOT SU2_PY/SU2_DOT || die
	ln -s ../../${P}-build/SU2_GEO/src/SU2_GEO SU2_PY/SU2_GEO || die
	ln -s ../../${P}-build/SU2_SOL/src/SU2_SOL SU2_PY/SU2_SOL || die

	export SU2_RUN="${S}/SU2_PY"
	export SU2_HOME="${S}"
	export PATH=$PATH:$SU2_RUN
	export PYTHONPATH=$PYTHONPATH:$SU2_RUN

	einfo "Running UnitTests ..."
	../${P}-build/UnitTests/test_driver || die

	pushd TestCases/ || die
	if use mpi ; then
		${EPYTHON} parallel_regression.py || die
		if use tutorials ; then
			${EPYTHON} tutorials.py || die
		fi
	else
		${EPYTHON} serial_regression.py || die
	fi
	popd || die
}

src_install() {
	meson_src_install
	mkdir -p "${D}$(python_get_sitedir)" || die
	mv "${ED}"/usr/bin/{FSI_tools,SU2,SU2_Nastran,*.py} -t "${D}$(python_get_sitedir)" || die
	python_optimize "${D}/$(python_get_sitedir)"

	if use tutorials ; then
		insinto "/usr/share/${P}"
		doins -r Tutorials
	fi
}
