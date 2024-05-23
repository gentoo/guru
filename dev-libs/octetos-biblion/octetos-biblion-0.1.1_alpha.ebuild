# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

MYPV="${PV/_alpha/-alpha/}"

DESCRIPTION="Library for reading biblia."
HOMEPAGE="https://github.com/azaeldevel/octetos-core"
SRC_URI="https://github.com/azaeldevel/${PN}/archive/${MYPV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${MYPV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/octetos-core"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/cunit"

src_prepare() {
	default
	eautoreconf -fi
}
