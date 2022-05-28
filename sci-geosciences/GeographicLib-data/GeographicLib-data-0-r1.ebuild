# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MYPN="${PN/-data/}"

DESCRIPTION="Datasets for GeographicLib"
HOMEPAGE="https://sourceforge.net/projects/geographiclib/"
S="${WORKDIR}"

SLOT="0"
KEYWORDS="~amd64"
LICENSE="public-domain"

IUSE_GEOIDS_DATASETS="
	geoids_datasets_egm84-30
	geoids_datasets_egm84-15
	geoids_datasets_egm96-15
	geoids_datasets_egm96-5
	geoids_datasets_egm2008-5
	geoids_datasets_egm2008-2-5
	+geoids_datasets_egm2008-1
"
IUSE_GRAVITY_MODELS="
	gravity_models_egm84
	gravity_models_egm96
	+gravity_models_egm2008
	gravity_models_wgs84
"
IUSE_MAGNETIC_MODELS="
	magnetic_models_wmm2010
	magnetic_models_wmm2015v2
	+magnetic_models_wmm2020
	magnetic_models_igrf11
	magnetic_models_igrf12
	magnetic_models_emm2010
	magnetic_models_emm2015
	magnetic_models_emm2017
"
IUSE="${IUSE_GEOIDS_DATASETS} ${IUSE_GRAVITY_MODELS} ${IUSE_MAGNETIC_MODELS}"

REQUIRED_USE="
	|| (
		${IUSE_GEOIDS_DATASETS/+/}
		${IUSE_GRAVITY_MODELS/+/}
		${IUSE_MAGNETIC_MODELS/+/}
	)
"

COMMON_URI="https://sourceforge.net/projects/${MYPN}/files"
SRC_URI="
	geoids_datasets_egm84-30?	( ${COMMON_URI}/geoids-distrib/egm84-30.tar.bz2		-> geoids-egm84-30.tar.bz2	)
	geoids_datasets_egm84-15?	( ${COMMON_URI}/geoids-distrib/egm84-15.tar.bz2		-> geoids-egm84-15.tar.bz2	)
	geoids_datasets_egm96-15?	( ${COMMON_URI}/geoids-distrib/egm96-15.tar.bz2		-> geoids-egm96-15.tar.bz2	)
	geoids_datasets_egm96-5?	( ${COMMON_URI}/geoids-distrib/egm96-5.tar.bz2		-> geoids-egm96-5.tar.bz2	)
	geoids_datasets_egm2008-5?	( ${COMMON_URI}/geoids-distrib/egm2008-5.tar.bz2	-> geoids-egm2008-5.tar.bz2	)
	geoids_datasets_egm2008-2-5?	( ${COMMON_URI}/geoids-distrib/egm2008-2_5.tar.bz2	-> geoids-egm2008-2_5.tar.bz2	)
	geoids_datasets_egm2008-1?	( ${COMMON_URI}/geoids-distrib/egm2008-1.tar.bz2	-> geoids-egm2008-1.tar.bz2	)

	gravity_models_egm84?		( ${COMMON_URI}/gravity-distrib/egm84.tar.bz2		-> gravity-egm84.tar.bz2	)
	gravity_models_egm96?		( ${COMMON_URI}/gravity-distrib/egm96.tar.bz2		-> gravity-egm96.tar.bz2	)
	gravity_models_egm2008?		( ${COMMON_URI}/gravity-distrib/egm2008.tar.bz2		-> gravity-egm2008.tar.bz2	)
	gravity_models_wgs84?		( ${COMMON_URI}/gravity-distrib/wgs84.tar.bz2		-> gravity-wgs84.tar.bz2	)

	magnetic_models_wmm2010?	( ${COMMON_URI}/magnetic-distrib/wmm2010.tar.bz2	-> magnetic-wmm2010.tar.bz2	)
	magnetic_models_wmm2015v2?	( ${COMMON_URI}/magnetic-distrib/wmm2015v2.tar.bz2	-> magnetic-wmm2015v2.tar.bz2	)
	magnetic_models_wmm2020?	( ${COMMON_URI}/magnetic-distrib/wmm2020.tar.bz2	-> magnetic-wmm2020.tar.bz2	)
	magnetic_models_igrf11?		( ${COMMON_URI}/magnetic-distrib/igrf11.tar.bz2		-> magnetic-igrf11.tar.bz2	)
	magnetic_models_igrf12?		( ${COMMON_URI}/magnetic-distrib/igrf12.tar.bz2		-> magnetic-igrf12.tar.bz2	)
	magnetic_models_emm2010?	( ${COMMON_URI}/magnetic-distrib/emm2010.tar.bz2	-> magnetic-emm2010.tar.bz2	)
	magnetic_models_emm2015?	( ${COMMON_URI}/magnetic-distrib/emm2015.tar.bz2	-> magnetic-emm2015.tar.bz2	)
	magnetic_models_emm2017?	( ${COMMON_URI}/magnetic-distrib/emm2017.tar.bz2	-> magnetic-emm2017.tar.bz2	)
"

RDEPEND="sci-geosciences/GeographicLib"

src_install() {
	local GEODATAPATH="/usr/share/${MYPN,,}"
	insinto "${GEODATAPATH}"
	doins -r "${WORKDIR}"/*
}
