# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit meson python-single-r1

DESCRIPTION="SU2: An Open-Source Suite for Multiphysics Simulation and Design"
HOMEPAGE="https://su2code.github.io/"
SRC_URI="
	https://github.com/su2code/SU2/archive/v${PV}.tar.gz -> ${P}.tar.gz
	test? ( https://github.com/su2code/TestCases/archive/v${PV}.tar.gz -> ${P}-TestCases.tar.gz )
	tutorials? ( https://github.com/su2code/Tutorials/archive/v${PV}.tar.gz -> ${P}-Tutorials.tar.gz )
"

LICENSE="
	LGPL-2.1
	tecio? ( tecio_license_agreement )
	parmetis? ( all-rights-reserved free-noncomm )
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="autodiff cgns directdiff librom mixed-precision mkl +mpi mpp openblas openmp parmetis pastix python tecio test tutorials"
# TODO: do not force openblas

REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	parmetis? ( mpi )
	pastix? (
		mpi
		|| ( openblas mkl )
	)
	test? ( mpi python tutorials )
	?? ( openblas mkl )
	?? ( directdiff pastix )
"

# Tests fail with FEATURES="network-sandbox" for most versions of openmpi and mpich it with error:
# "No network interfaces were found for out-of-band communications.
#  We require at least one available network for out-of-band messaging."
PROPERTIES="test_network"
RESTRICT="!test? ( test )"

RDEPEND="
	${PYTHON_DEPS}
	cgns? ( >=sci-libs/cgnslib-4 )
	librom? ( sci-libs/libROM )
	mkl? ( sci-libs/mkl )
	mpi? ( virtual/mpi[cxx] )
	mpp? ( sci-libs/Mutationpp:= )
	openblas? ( sci-libs/openblas )
	pastix? (
		<sci-libs/pastix-6[mpi?]
		sci-libs/scotch
	)
	python? ( $(python_gen_cond_dep '
			dev-python/mpi4py[${PYTHON_USEDEP}]
			dev-python/xlwt[${PYTHON_USEDEP}]
			dev-python/matplotlib[${PYTHON_USEDEP}]
			dev-python/scipy[${PYTHON_USEDEP}]
			dev-python/numpy[${PYTHON_USEDEP}]
		')
	)
"
DEPEND="
	${RDEPEND}
	dev-cpp/cli11:=
	dev-cpp/MEL:=
	autodiff? (
		sci-libs/CoDiPack:=
		mpi? ( >sci-libs/MeDiPack-1.2:= )
		openmp? ( sci-libs/OpDiLib:= )
	)
	directdiff? (
		sci-libs/CoDiPack:=
		mpi? ( >sci-libs/MeDiPack-1.2:= )
	)
	tecio? ( >=dev-libs/boost-1.76.0:= )
	test? ( <dev-cpp/catch-3:0 )
"
BDEPEND="
	python? ( dev-lang/swig )
	virtual/pkgconfig
"

DOCS=( "README.md" "SU2_PY/documentation.txt" )

PATCHES=(
	"${FILESDIR}/${PN}-7.0.4-unbundle_boost.patch"
	"${FILESDIR}/${PN}-7.1.0-fix-env.patch"
	"${FILESDIR}/${P}-system-libraries.patch"
	"${FILESDIR}/${PN}-7.2.0-DESTDIR.patch"
	"${FILESDIR}/${PN}-7.2.0-fix-headers.patch"

)

src_unpack() {
	unpack "${P}.tar.gz"
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
	rm -rf externals/{CLI11,autotools,catch2,cgns,codi,medi,mel,meson,ninja,opdi} || die

	default
	# boost Geometry requires c++14 since >=boost-1.75
	sed -i -e 's:cpp_std=c++11:cpp_std=c++14:' meson.build || die

	# Force Disable parmetis support in meson.build (configure.ac has optional switch)
	use !parmetis && { sed -i -e "/parmetis/Id" meson.build || die ; }

	# Replace platform.processor() with platform.machine()
	# to get 'x86_64' in common case instead of full CPU name
	sed -i "s/processor()/machine()/" TestCases/TestCase.py || die

	# Fix python3.11 test compatibility (drop universal newline parameter - it's used by default)
	sed -i "s/'U'//g" TestCases/TestCase.py || die

	# Disable failed tests
	sed -i "/append(tutorial_unst_naca0012)/s/./#&/" TestCases/tutorials.py || die # reasults sligtly differs

	sed -i "/append(turbmod_sa_neg_rae2822/s/./#&/" TestCases/parallel_regression.py || die
	sed -i "/append(dyn_fsi/s/./#&/" TestCases/parallel_regression.py || die
	sed -i "/append(fd_sp_pinArray_cht_2d_dp_hf/s/./#&/" TestCases/parallel_regression.py || die
	sed -i "/append(fd_sp_pinArray_cht_2d_dp_hf/s/./#&/" TestCases/parallel_regression.py || die
	sed -i "/append(coolprop_fluidModel/s/./#&/" TestCases/parallel_regression.py || die
	sed -i "/append(coolprop_transportModel/s/./#&/" TestCases/parallel_regression.py || die
	sed -i "/append(uniform_flow/s/./#&/" TestCases/parallel_regression.py || die
	sed -i "/append(pywrapper_square_cylinder/s/./#&/" TestCases/parallel_regression.py || die

	sed -i "/append(discadj_fsi2/s/./#&/" TestCases/parallel_regression_AD.py || die
	sed -i "/append(dyn_discadj_fsi/s/./#&/" TestCases/parallel_regression_AD.py || die
}

src_configure() {
	if use mpi ; then
		export CC=mpicc
		export CXX=mpicxx
	fi

	local emesonargs=(
		$(meson_feature mpi with-mpi)
		$(meson_use autodiff enable-autodiff)
		$(meson_use cgns enable-cgns)
		$(meson_use directdiff enable-directdiff)
		$(meson_use librom enable-librom)
		$(meson_use mixed-precision enable-mixedprec)
		$(meson_use mkl enable-mkl)
		$(meson_use mpi custom-mpi)
		$(meson_use mpp enable-mpp)
		$(meson_use openblas enable-openblas)
		$(meson_use openmp with-omp)
		$(meson_use pastix enable-pastix)
		$(meson_use python enable-pywrapper)
		$(meson_use tecio enable-tecio)
		$(meson_use test enable-tests)
	)
	meson_src_configure
}

src_test() {
	ln -sf ../../${P}-build/SU2_CFD/src/SU2_CFD SU2_PY/SU2_CFD || die
	ln -sf ../../${P}-build/SU2_DEF/src/SU2_DEF SU2_PY/SU2_DEF || die
	ln -sf ../../${P}-build/SU2_DOT/src/SU2_DOT SU2_PY/SU2_DOT || die
	ln -sf ../../${P}-build/SU2_GEO/src/SU2_GEO SU2_PY/SU2_GEO || die
	ln -sf ../../${P}-build/SU2_SOL/src/SU2_SOL SU2_PY/SU2_SOL || die
	ln -sf ../../${P}-build/SU2_PY/pySU2/pysu2.py SU2_PY/pysu2.py || die
	ln -sf ../../${P}-build/SU2_PY/pySU2/_pysu2.so SU2_PY/_pysu2.so || die
	if use autodiff ; then
		ln -sf ../../${P}-build/SU2_CFD/src/SU2_CFD_AD SU2_PY/SU2_CFD_AD || die
		ln -sf ../../${P}-build/SU2_DOT/src/SU2_DOT_AD SU2_PY/SU2_DOT_AD || die
		ln -sf ../../${P}-build/SU2_PY/pySU2/pysu2ad.py SU2_PY/pysu2ad.py || die
		ln -sf ../../${P}-build/SU2_PY/pySU2/_pysu2ad.so SU2_PY/_pysu2ad.so || die
		if use directdiff ; then
			ln -sf ../../${P}-build/SU2_CFD/src/SU2_CFD_DIRECTDIFF SU2_PY/SU2_CFD_DIRECTDIFF || die
		fi
	fi

	export SU2_RUN="${S}/SU2_PY"
	export SU2_HOME="${S}"
	export PATH="${PATH}:${SU2_RUN}"
	export PYTHONPATH="${PYTHONPATH}:${SU2_RUN}"

	if use autodiff ; then
		einfo "Running UnitTests ..."
		../${P}-build/UnitTests/test_driver_AD || die
		../${P}-build/UnitTests/test_driver_DD || die
#	else
	## Failed for SU2-7.5.1 with error:
	## application called MPI_Abort(MPI_COMM_WORLD, 1) - process 0
	## [unset]: write_line error; fd=-1 buf=:cmd=abort exitcode=1
	## system msg for write_line failure : Bad file descriptor
#		../${P}-build/UnitTests/test_driver || die
	fi

	pushd TestCases/ || die
	# Currently Tests always use mpi.
	# Description on the page https://su2code.github.io/docs/Test-Cases/ states:
	# "Note: While many of the cases are used for regression testing, the test case suite
	# is provided without any guarantees on performance or expected results.
	# Tutorials (which are more thoroughly checked for convergence and results) can be found here."
	# Therefore bundled parmetis/metis are used otherwise it results in numerous Tutorials tests failures.
	if use mpi ; then
		# Running Tutorials tests is preferred than TestCases
		if use tutorials ; then
			${EPYTHON} tutorials.py || die
		fi
		if use autodiff ; then
			${EPYTHON} parallel_regression_AD.py || die
		fi
		${EPYTHON} parallel_regression.py || die
	else
		if use autodiff ; then
			${EPYTHON} serial_regression_AD.py || die
		fi
		${EPYTHON} serial_regression.py || die
	fi
	popd || die
}

src_install() {
	DESTDIR="${D}" meson_src_install

	mkdir -p "${D}$(python_get_sitedir)/SU2_PY" || die
	if use python; then
		mv "${ED}"/usr/bin/*.so -t "${D}$(python_get_sitedir)/SU2_PY" || die
	fi
	mv "${ED}"/usr/bin/{FSI_tools,SU2,SU2_Nastran} -t "${D}$(python_get_sitedir)" || die
	mv "${ED}"/usr/bin/*.py -t "${D}$(python_get_sitedir)/SU2_PY" || die
	python_optimize "${D}/$(python_get_sitedir)"

	if use tutorials ; then
		insinto "/usr/share/${PN}"
		doins -r Tutorials
	fi

	local SU2_RUN="$(python_get_sitedir)/SU2_PY"
	echo SU2_RUN="${SU2_RUN}" > 99SU2
	echo PATH="${SU2_RUN}" >> 99SU2
	echo PYTHONPATH="${SU2_RUN}" >> 99SU2

	doenvd 99SU2
}
