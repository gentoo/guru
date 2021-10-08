# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="ae57618c4e7b030b59707b8c156a6e2a94a6efd0"
MYP="${PN}-${COMMIT}"
PYTHON_COMPAT=( python3_{8..10} )

inherit autotools flag-o-matic fortran-2 pam python-single-r1

DESCRIPTION="A general purpose Multibody Dynamics analysis software"
HOMEPAGE="https://www.mbdyn.org"
SRC_URI="https://public.gitlab.polimi.it/DAER/mbdyn/-/archive/${COMMIT}/${MYP}.tar.bz2"
S="${WORKDIR}/${MYP}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
#	mbdyn-module-FMU # needs fmi-library
#	mbdyn-module-aerodyn # needs aerodyn
#	mbdyn-module-cudatest # needs cuda
IUSE_MBDYN_MODULE="
	mbdyn-module-asynchronous_machine
	mbdyn-module-autodiff_test
	mbdyn-module-ballbearing_contact
	mbdyn-module-bullet
	mbdyn-module-charm
	mbdyn-module-constlaw-f90
	mbdyn-module-constlaw-f95
	mbdyn-module-constlaw
	mbdyn-module-cont-contact
	mbdyn-module-controller
	mbdyn-module-convtest
	mbdyn-module-cyclocopter
	mbdyn-module-damper-gandhi
	mbdyn-module-damper-graall
	mbdyn-module-damper-hydraulic
	mbdyn-module-damper
	mbdyn-module-diff
	mbdyn-module-dot
	mbdyn-module-drive-test
	mbdyn-module-drive
	mbdyn-module-dummy
	mbdyn-module-eu2phi
	mbdyn-module-fab-electric
	mbdyn-module-fab-motion
	mbdyn-module-fab-sbearings
	mbdyn-module-fabricate
	mbdyn-module-flightgear
	mbdyn-module-friction
	mbdyn-module-friction3
	mbdyn-module-hfelem
	mbdyn-module-hid
	mbdyn-module-hunt-crossley
	mbdyn-module-hydrodynamic_plain_bearing
	mbdyn-module-hydrodynamic_plain_bearing2
	mbdyn-module-imu
	mbdyn-module-indvel
	mbdyn-module-inline_friction
	mbdyn-module-inplane_friction
	mbdyn-module-journal_bearing
	mbdyn-module-leapmotion
	mbdyn-module-loadinc
	mbdyn-module-marble
	mbdyn-module-md
	mbdyn-module-mds
	mbdyn-module-minmaxdrive
	mbdyn-module-multi_step_drive
	mbdyn-module-muscles
	mbdyn-module-namespace
	mbdyn-module-nodedistdrive
	mbdyn-module-nonsmooth-node
	mbdyn-module-ns
	mbdyn-module-octave
	mbdyn-module-randdrive
	mbdyn-module-rollercoaster
	mbdyn-module-rotor-loose-coupling
	mbdyn-module-scalarfunc
	mbdyn-module-switch_drive
	mbdyn-module-tclpgin
	mbdyn-module-template
	mbdyn-module-template2
	mbdyn-module-triangular_contact
	mbdyn-module-udunits
	mbdyn-module-uni_in_plane
	mbdyn-module-wheel2
	mbdyn-module-wheel4
"
IUSE="${IUSE_MBDYN_MODULE//_/-} ann arpack autodiff blender boost bullet chaco crypt
debug eig ginac jdqz +mbc metis mpi multithread-naive netcdf octave openblas pam
pastix pmpi python qrupdate rt sasl schur sparse superlu tests threads udunits +y12"
# taucs rtai

#	dev-libs/blitz
RDEPEND="
	dev-libs/libltdl
	virtual/blas
	virtual/lapack

	ann? ( sci-libs/ann )
	arpack? ( sci-libs/arpack )
	blender? ( media-gfx/blender:= )
	boost? ( dev-libs/boost )
	bullet? ( sci-physics/bullet )
	chaco? ( sci-mathematics/chaco )
	crypt? ( virtual/libcrypt )
	ginac? ( sci-mathematics/ginac )
	jdqz? ( sci-libs/jdqz )
	mbdyn-module-damper? ( sci-libs/gsl )
	mpi? ( virtual/mpi[cxx] )
	metis? ( sci-libs/metis )
	netcdf? ( sci-libs/netcdf-cxx:* )
	octave? ( sci-mathematics/octave )
	openblas? ( sci-libs/openblas )
	pam? ( sys-libs/pam )
	pastix? ( sci-libs/pastix )
	python? (
		${PYTHON_DEPS}
		$(python_gen_cond_dep 'dev-python/numpy[${PYTHON_USEDEP}]')
	)
	qrupdate? ( sci-libs/qrupdate )
	sasl? ( dev-libs/cyrus-sasl )
	sparse? (
		sci-libs/klu
		sci-libs/umfpack
	)
	superlu? ( sci-libs/superlu_mt )
	threads? ( dev-libs/libatomic_ops )
	udunits? ( sci-libs/udunits )
"
#	taucs? ( sci-libs/taucs )
DEPEND="
	${RDEPEND}
	blender? ( sys-apps/pkgcore )
"
BDEPEND="python? ( dev-lang/swig )"

PATCHES=(
	"${FILESDIR}/${PN}-find-bullet.patch"
	"${FILESDIR}/${PN}-octave-no-global-install.patch"
)
#	"${FILESDIR}/${PN}-respect-libtool.patch"
REQUIRED_USE="
	mbdyn-module-bullet? ( bullet )
	mbdyn-module-octave? ( octave )
	mbdyn-module-udunits? ( udunits )
	mbdyn-module-wheel4? ( ginac )
	multithread-naive? ( threads )
	pmpi? ( mpi )
	python? ( ${PYTHON_REQUIRED_USE} )
	schur? (
		|| ( chaco metis )
		mpi
	)
"
#	?? ( rt rtai )

pkg_setup() {
	fortran-2_pkg_setup
}

src_prepare() {
	default
	eautoreconf
	#from bootstrap.sh
	if test -d contrib ; then
		for i in `find contrib -name 'bootstrap.sh'` ; do
			dir=`echo "${i}" | sed "s/\(.*\)\/bootstrap\.sh/\1/"`
			pushd "${dir}" || die
			eautoreconf
			popd || die
		done
	fi
}

src_configure() {
	python_setup
	append-cxxflags "-I/usr/include/bullet"
	local myconf=(
		--disable-static
		--disable-Werror
		--enable-runtime-loading
		--with-lapack
		--without-charm
		--without-g2c
		--without-goto
		--without-harwell
		--without-pardiso
		--without-rtai
		--without-static-modules
		--without-strumpack
		--without-wsmp

		$(use_enable autodiff)
		$(use_enable crypt)
		$(use_enable debug)
		$(use_enable eig)
		$(use_enable mbc)
		$(use_enable multithread-naive)
		$(use_enable netcdf)
		$(use_enable octave)
		$(use_enable octave octave-utils)
		$(use_enable python)
		$(use_enable schur)
		$(use_enable tests install_test_progs)
		$(use_enable threads multithread)

		$(use_with ann)
		$(use_with arpack)
		$(use_with boost)
		$(use_with bullet)
		$(use_with ginac)
		$(use_with jdqz)
		$(use_with metis)
		$(use_with openblas)
		$(use_with pam)
		$(use_with pastix)
		$(use_with qrupdate)
		$(use_with rt)
		$(use_with sasl sasl2)
		$(use_with sparse klu)
		$(use_with sparse suitesparseqr)
		$(use_with sparse umfpack)
		$(use_with superlu)
		$(use_with threads)
		$(use_with y12)
	)

	if ( use autodiff && use sparse ); then
		myconf+=( "--enable-sparse-autodiff" )
	else
		myconf+=( "--disable-sparse-autodiff" )
	fi
	if ( use debug && use mpi ); then
		myconf+=( "--enable-debug-mpi" )
	else
		myconf+=( "--disable-debug-mpi" )
	fi
	if use mpi; then
		if use pmpi; then
			myconf+=( "--with-mpi=pmpi" )
		else
			myconf+=( "--with-mpi" )
		fi
	else
		myconf+=( "--without-mpi" )
	fi

	declare -A mbdynmodules
	for m in ${IUSE_MBDYN_MODULE} ; do
		mbdynmodules[${m//_/-}]="${m/mbdyn-module-/}"
	done

	local usemodules=""
	for u in ${IUSE_MBDYN_MODULE//_/-} ; do
		use ${u} && usemodules+=" ${mbdynmodules[${u}]}"
	done

	# remove leading whitespace characters
	usemodules="${usemodules#"${usemodules%%[![:space:]]*}"}"

	myconf+=( "--with-module=\"${usemodules}\"" )

	econf "${myconf[@]}"
}

src_install() {
	mkdir -p "${HOME}/octave" || die
#	octave --exec "pkg prefix ${T}" || die
	emake DESTDIR="${D}" install

	if use blender; then
		local blenderslots="$(pquery -I media-gfx/blender --one-attr slot)"
		local blenderscriptdir
		for i in $blenderslots ; do
			blenderscriptdir="/usr/share/blender/${i}/scripts/"
			insinto "${blenderscriptdir}"
			doins -r contrib/blenderandmbdyn
		done
	fi

	if use python; then
		local site="${D}/$(python_get_sitedir)"
		mkdir -p "${site}" || die
		mv "${D}/usr/libexec/mbpy" "${site}" || die
	fi

	use pam && dopamd etc/pam.d/mbdyn

	mkdir -p "${D}/usr/share/octave/mbdyn" || die
	mv "${D}"/usr/share/octave/*.m "${D}/usr/share/octave/mbdyn" || die

	if use octave; then
		insinto "/usr/share/octave/mbdyn"
		doins -r contrib/MLS/.
	fi

	find "${D}" -name '*.la' -delete || die
}
