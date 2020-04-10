# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{6,7,8} )

inherit cmake distutils-r1

MY_PN="GeographicLib"
MY_PV=$(ver_rs 2 -)
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="C++ library for converting geographic coordinate systems"
HOMEPAGE="https://sourceforge.net/projects/geographiclib/"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE_GEOIDS_DATASETS="
	geoids_datasets_egm84-30
	geoids_datasets_egm84-15
	geoids_datasets_egm96-15
	geoids_datasets_egm96-5
	geoids_datasets_egm2008-5
	geoids_datasets_egm2008-2-5
	geoids_datasets_egm2008-1
"
IUSE_GRAVITY_MODELS="
	gravity_models_egm84
	gravity_models_egm96
	gravity_models_egm2008
	gravity_models_wgs84
"
IUSE_MAGNETIC_MODELS="
	magnetic_models_wmm2010
	magnetic_models_wmm2015v2
	magnetic_models_wmm2020
	magnetic_models_igrf11
	magnetic_models_igrf12
	magnetic_models_emm2010
	magnetic_models_emm2015
	magnetic_models_emm2017
"
IUSE_PRECISION="
	precision_arbitrary
	+precision_double
	precision_long-double
	precision_quad
	precision_single
"
IUSE="${IUSE_GEOIDS_DATASETS} ${IUSE_GRAVITY_MODELS} ${IUSE_MAGNETIC_MODELS} ${IUSE_PRECISION} boost doc examples geoids gravity magnetic python"
IUSE_EXPAND="GEOIDS_DATASETS GRAVITY_MODELS MAGNETIC_MODELS PRECISION"

REQUIRED_USE="
	^^ ( ${IUSE_PRECISION/+/} )
	geoids? ( || ( ${IUSE_GEOIDS_DATASETS/+/} ) )
	gravity? ( || ( ${IUSE_GRAVITY_MODELS/+/} ) )
	magnetic? ( || ( ${IUSE_MAGNETIC_MODELS/+/} ) )
	!geoids? ( ${IUSE_GEOIDS_DATASETS/geoids/!geoids} )
	!gravity? ( ${IUSE_GRAVITY_MODELS/gravity/!gravity} )
	!magnetic? ( ${IUSE_MAGNETIC_MODELS/magnetic/!magnetic} )
	python? ( ${PYTHON_REQUIRED_USE} )
"

COMMON_URI="https://sourceforge.net/projects/${PN}/files"
SRC_URI="
${COMMON_URI}/distrib/${MY_P}.tar.gz/download -> ${P}.tar.gz

geoids_datasets_egm84-30?         ( ${COMMON_URI}/geoids-distrib/egm84-30.tar.bz2	-> geoids-egm84-30.tar.bz2	)
geoids_datasets_egm84-15?         ( ${COMMON_URI}/geoids-distrib/egm84-15.tar.bz2	-> geoids-egm84-15.tar.bz2	)
geoids_datasets_egm96-15?         ( ${COMMON_URI}/geoids-distrib/egm96-15.tar.bz2	-> geoids-egm96-15.tar.bz2	)
geoids_datasets_egm96-5?          ( ${COMMON_URI}/geoids-distrib/egm96-5.tar.bz2	-> geoids-egm96-5.tar.bz2	)
geoids_datasets_egm2008-5?        ( ${COMMON_URI}/geoids-distrib/egm2008-5.tar.bz2	-> geoids-egm2008-5.tar.bz2	)
geoids_datasets_egm2008-2-5?      ( ${COMMON_URI}/geoids-distrib/egm2008-2_5.tar.bz2	-> geoids-egm2008-2_5.tar.bz2	)
geoids_datasets_egm2008-1?        ( ${COMMON_URI}/geoids-distrib/egm2008-1.tar.bz2	-> geoids-egm2008-1.tar.bz2	)

gravity_models_egm84?            ( ${COMMON_URI}/gravity-distrib/egm84.tar.bz2		-> gravity-egm84.tar.bz2	)
gravity_models_egm96?            ( ${COMMON_URI}/gravity-distrib/egm96.tar.bz2		-> gravity-egm96.tar.bz2	)
gravity_models_egm2008?          ( ${COMMON_URI}/gravity-distrib/egm2008.tar.bz2	-> gravity-egm2008.tar.bz2	)
gravity_models_wgs84?            ( ${COMMON_URI}/gravity-distrib/wgs84.tar.bz2		-> gravity-wgs84.tar.bz2	)

magnetic_models_wmm2010?         ( ${COMMON_URI}/magnetic-distrib/wmm2010.tar.bz2	-> magnetic-wmm2010.tar.bz2	)
magnetic_models_wmm2015v2?       ( ${COMMON_URI}/magnetic-distrib/wmm2015v2.tar.bz2	-> magnetic-wmm2015v2.tar.bz2	)
magnetic_models_wmm2020?         ( ${COMMON_URI}/magnetic-distrib/wmm2020.tar.bz2	-> magnetic-wmm2020.tar.bz2	)
magnetic_models_igrf11?          ( ${COMMON_URI}/magnetic-distrib/igrf11.tar.bz2	-> magnetic-igrf11.tar.bz2	)
magnetic_models_igrf12?          ( ${COMMON_URI}/magnetic-distrib/igrf12.tar.bz2	-> magnetic-igrf12.tar.bz2	)
magnetic_models_emm2010?         ( ${COMMON_URI}/magnetic-distrib/emm2010.tar.bz2	-> magnetic-emm2010.tar.bz2	)
magnetic_models_emm2015?         ( ${COMMON_URI}/magnetic-distrib/emm2015.tar.bz2	-> magnetic-emm2015.tar.bz2	)
magnetic_models_emm2017?         ( ${COMMON_URI}/magnetic-distrib/emm2017.tar.bz2	-> magnetic-emm2017.tar.bz2	)
"
#TODO: find out the licenses of the geoid and gravity datasets
LICENSE="
	MIT
	geoids? ( public-domain )
	gravity? ( public-domain )
	magnetic? ( public-domain )
"

RDEPEND="
	>=dev-libs/boost-1.65.0
"
DEPEND="
	${RDEPEND}
	doc? (
		>=app-doc/doxygen-1.8.7
		>=dev-lang/perl-5.26.1-r1
		>=dev-python/sphinx-1.6.3-r2
		>=sys-apps/util-linux-2.31
	)
"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests setup.py
# there are additional docs in the python dir
distutils_enable_sphinx python/doc

src_prepare() {
	#TODO: strip cflags
#	sed -i "s|CXXFLAGS = -g -Wall -Wextra -O3 -std=c++0x||" tools/Makefile.mk || die
#	sed -i "s|CXXFLAGS = -g -Wall -Wextra -O3 -std=c++0x||" src/Makefile.mk || die

	cmake_src_prepare

	if use python; then
		cd "python" || die
		distutils-r1_python_prepare_all
		cd ".." || die
	fi
}

src_configure() {
	local precision
	use precision_arbitrary		&& precision="5"
	use precision_double		&& precision="2"
	use precision_long-double	&& precision="3"
	use precision_quad		&& precision="4"
	use precision_single		&& precision="1"

	export GEODATAPATH="/usr/share/${PN}"

	local mycmakeargs=(
		-DGEOGRAPHICLIB_DOCUMENTATION=$(usex doc ON OFF)
		-DGEOGRAPHICLIB_LIB_TYPE="SHARED"
		-DUSE_BOOST_FOR_EXAMPLES=$(usex boost ON OFF)
		-DGEOGRAPHICLIB_PRECISION="${precision}"
		-DGEOGRAPHICLIB_DATA="${GEODATAPATH}"
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile

	if use python; then
		cd "python" || die
		python_foreach_impl distutils-r1_python_compile
		cd ".." || die
		use doc && build_sphinx python/doc
	fi
}

src_test() {
	# Only 1 failing test in the C code, python passes for me
	cmake_src_test

	if use python; then
		cd "python" || die
		python_foreach_impl python_test
		cd ".." || die
	fi
}

src_install() {
	insinto "${GEODATAPATH}/geoids"
	use geoids && doins -r "${WORKDIR}"/geoids/.
	insinto "${GEODATAPATH}/gravity"
	use gravity && doins -r "${WORKDIR}"/gravity/.
	insinto "${GEODATAPATH}/magnetic"
	use magnetic && doins -r "${WORKDIR}"/magnetic/.

	cmake_src_install

	# remove python things added by the cmake_src_install function
	# these are installed in the wrong python dir
	rm -rf "${D}/usr/$(get_libdir)/python" || die
	# if use python we re-add these python files correctly
	if use python; then
		cd "python" || die
		python_foreach_impl distutils-r1_python_install
		cd ".."
	fi

	#TODO: find out if java stuff need something

	# Installs to wrong doc dir for some reason
	# Also happens with USE="-doc"
	mv "${D}/usr/share/doc/${MY_PN}" "${D}/usr/share/doc/${PN}" || die
}
