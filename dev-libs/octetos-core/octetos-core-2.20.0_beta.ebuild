# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

MYPV="${PV/_beta/-beta/}"

DESCRIPTION="C/C++ library to mainly provide Semantic Versioned implementation"
HOMEPAGE="https://github.com/azaeldevel/octetos-core"
SRC_URI="https://github.com/azaeldevel/${PN}/archive/${MYPV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${MYPV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/libconfig
	dev-perl/XML-Parser
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/cunit
	dev-util/intltool
	sys-devel/bison
	>=sys-devel/gcc-8.1
"

src_prepare() {
	default
	eautoreconf -fi
}
