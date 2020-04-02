# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{6,7} )

inherit cmake-utils

MY_PN="GeographicLib"
MY_PV=$(ver_rs 2 -)
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="C++ library for converting geographic coordinate systems"
HOMEPAGE="https://sourceforge.net/projects/geographiclib/"

SLOT="0"
KEYWORDS="~amd64"
IUSE_GEOID_DATASET="
	geoid_dataset_egm84-30
	geoid_dataset_egm84-15
	geoid_dataset_egm96-15
	geoid_dataset_egm96-5
	geoid_dataset_egm2008-5
	geoid_dataset_egm2008-2-5
	geoid_dataset_egm2008-1
"
IUSE_GRAVITY_MODEL="
	gravity_model_egm84
	gravity_model_egm96
	gravity_model_egm2008
	gravity_model_wgs84
"
IUSE_MAGNETIC_MODEL="
	magnetic_model_wmm2010
	magnetic_model_wmm2015v2
	magnetic_model_wmm2020
	magnetic_model_igrf11
	magnetic_model_igrf12
	magnetic_model_emm2010
	magnetic_model_emm2015
	magnetic_model_emm2017
"
IUSE_PRECISION="
	precision_arbitrary
	+precision_double
	precision_long-double
	precision_quad
	precision_single
"
IUSE="${IUSE_GEOID_DATASET} ${IUSE_GRAVITY_MODEL} ${IUSE_MAGNETIC_MODEL} ${IUSE_PRECISION} boost doc examples geoid gravity magnetic"
IUSE_EXPAND="GEOID_DATASET GRAVITY_MODEL MAGNETIC_MODEL PRECISION"
REQUIRED_USE="
	^^ ( ${IUSE_PRECISION/+/} )
	geoid? ( || ( ${IUSE_GEOID_DATASET/+/} ) )
	gravity? ( || ( ${IUSE_GRAVITY_MODEL/+/} ) )
	magnetic? ( || ( ${IUSE_MAGNETIC_MODEL/+/} ) )

"
SRC_URI="
https://sourceforge.net/projects/${PN}/files/distrib/${MY_P}.tar.gz/download -> ${P}.tar.gz

geoid_dataset_egm84-30?		( https://sourceforge.net/projects/geographiclib/files/geoids-distrib/egm84-30.tar.bz2 )
geoid_dataset_egm84-15?		( https://sourceforge.net/projects/geographiclib/files/geoids-distrib/egm84-15.tar.bz2 )
geoid_dataset_egm96-15?		( https://sourceforge.net/projects/geographiclib/files/geoids-distrib/egm96-15.tar.bz2 )
geoid_dataset_egm96-5?		( https://sourceforge.net/projects/geographiclib/files/geoids-distrib/egm96-5.tar.bz2 )
geoid_dataset_egm2008-5?	( https://sourceforge.net/projects/geographiclib/files/geoids-distrib/egm2008-5.tar.bz2 )
geoid_dataset_egm2008-2-5?	( https://sourceforge.net/projects/geographiclib/files/geoids-distrib/egm2008-2_5.tar.bz2 )
geoid_dataset_egm2008-1?	( https://sourceforge.net/projects/geographiclib/files/geoids-distrib/egm2008-1.tar.bz2 )

gravity_model_egm84?		( https://sourceforge.net/projects/geographiclib/files/gravity-distrib/egm84.tar.bz2 )
gravity_model_egm96?		( https://sourceforge.net/projects/geographiclib/files/gravity-distrib/egm96.tar.bz2 )
gravity_model_egm2008?		( https://sourceforge.net/projects/geographiclib/files/gravity-distrib/egm2008.tar.bz2 )
gravity_model_wgs84?		( https://sourceforge.net/projects/geographiclib/files/gravity-distrib/wgs84.tar.bz2 )

magnetic_model_wmm2010?		( https://sourceforge.net/projects/geographiclib/files/magnetic-distrib/wmm2010.tar.bz2 )
magnetic_model_wmm2015v2?	( https://sourceforge.net/projects/geographiclib/files/magnetic-distrib/wmm2015v2.tar.bz2 )
magnetic_model_wmm2020?		( https://sourceforge.net/projects/geographiclib/files/magnetic-distrib/wmm2020.tar.bz2 )
magnetic_model_igrf11?		( https://sourceforge.net/projects/geographiclib/files/magnetic-distrib/igrf11.tar.bz2 )
magnetic_model_igrf12?		( https://sourceforge.net/projects/geographiclib/files/magnetic-distrib/igrf12.tar.bz2 )
magnetic_model_emm2010?		( https://sourceforge.net/projects/geographiclib/files/magnetic-distrib/emm2010.tar.bz2 )
magnetic_model_emm2015?		( https://sourceforge.net/projects/geographiclib/files/magnetic-distrib/emm2015.tar.bz2 )
magnetic_model_emm2017?		( https://sourceforge.net/projects/geographiclib/files/magnetic-distrib/emm2017.tar.bz2 )
"
#TODO: find out the licenses of the geoid and gravity datasets
LICENSE="
	MIT
	geoid? ( public-domain )
	gravity? ( public-domain )
	magnetic? ( public-domain )
"

RESTRICT="primaryuri"

RDEPEND="
	>=dev-libs/boost-1.65.0
"
DEPEND="
	${RDEPEND}
	doc? (
		>=app-doc/doxygen-1.8.7
		>=dev-python/sphinx-1.6.3-r2
		>=dev-lang/perl-5.26.1-r1
		>=sys-apps/util-linux-2.31
	)
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	#TODO: strip cflags
	default
}

src_configure() {
	local precision
	use precision_arbitrary		&& precision="5"
	use precision_double		&& precision="2"
	use precision_long-double	&& precision="3"
	use precision_quad		&& precision="4"
	use precision_single		&& precision="1"

	local mycmakeargs=(
		-DGEOGRAPHICLIB_DOCUMENTATION=$(usex doc ON OFF)
		-DGEOGRAPHICLIB_LIB_TYPE="SHARED"
		-DUSE_BOOST_FOR_EXAMPLES=$(usex boost ON OFF)
		-DGEOGRAPHICLIB_PRECISION="${precision}"
	)
	cmake-utils_src_configure
}

src_install() {
	default
	#TODO: install python bindings correctly
	#TODO: install datasets
	#TODO: find out if java stuff need something
}
