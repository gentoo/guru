# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="ae57618c4e7b030b59707b8c156a6e2a94a6efd0"
MYP="${PN}-${COMMIT}"
PYTHON_COMPAT=( python3_{10..11} )

inherit autotools flag-o-matic fortran-2 pam python-single-r1

DESCRIPTION="A general purpose Multibody Dynamics analysis software"
HOMEPAGE="https://www.mbdyn.org"
SRC_URI="https://public.gitlab.polimi.it/DAER/mbdyn/-/archive/${COMMIT}/${MYP}.tar.bz2"
S="${WORKDIR}/${MYP}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
#	FMU # needs fmi-library
#	aerodyn # needs aerodyn
#	cudatest # needs cuda
MBDYN_MODULE=( asynchronous_machine autodiff_test ballbearing_contact bullet
charm constlaw-f90 constlaw-f95 constlaw cont-contact controller convtest
cyclocopter damper-gandhi damper-graall damper-hydraulic damper diff dot
drive-test drive dummy eu2phi fab-electric fab-motion fab-sbearings fabricate
flightgear friction friction3 hfelem hid hunt-crossley
hydrodynamic_plain_bearing hydrodynamic_plain_bearing2 imu indvel
inline_friction inplane_friction journal_bearing leapmotion loadinc marble md
mds minmaxdrive multi_step_drive muscles namespace nodedistdrive nonsmooth-node
ns octave randdrive rollercoaster rotor-loose-coupling scalarfunc switch_drive
tclpgin triangular_contact udunits uni_in_plane wheel2 wheel4 )

MBDYN_MODULE_REPLACED=( "${MBDYN_MODULE[@]//_/-}" )
IUSE_MBDYN_MODULE="${MBDYN_MODULE_REPLACED[@]/#/mbdyn_module_}"
IUSE="${IUSE_MBDYN_MODULE} ann arpack autodiff blender boost bullet chaco crypt
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
	mbdyn_module_damper? ( sci-libs/gsl )
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
	mbdyn_module_bullet? ( bullet )
	mbdyn_module_octave? ( octave )
	mbdyn_module_udunits? ( udunits )
	mbdyn_module_wheel4? ( ginac )
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

	local usemodules=""
	for m in ${MBDYN_MODULE[@]} ; do
		u="${m//_/-}"
		use "mbdyn_module_${u}" && usemodules+=" ${m}"
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

	mkdir -p "${D}/usr/share/octave/site/m/mbdyn" || die
	mv "${D}"/usr/share/octave/*.m "${D}/usr/share/octave/site/m/mbdyn" || die

	if use octave; then
		insinto "/usr/share/octave/site/m/mbdyn"
		doins -r contrib/MLS/.
	fi

	find "${D}" -name '*.la' -delete || die
}
