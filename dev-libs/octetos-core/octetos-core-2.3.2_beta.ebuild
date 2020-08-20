# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

MYPV="${PV/_beta/-beta/}"

DESCRIPTION="C/C++ library to mainly provide Semantic Versioned implementation"
HOMEPAGE="https://github.com/azaeldevel/octetos-core"
SRC_URI="https://github.com/azaeldevel/${PN}/archive/${MYPV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	>=sys-devel/gcc-8.1
	>=sys-devel/bison-3.1
	dev-libs/libconfig
	dev-perl/XML-Parser
	dev-util/intltool
"

S="${WORKDIR}/${PN}-${MYPV}"

src_prepare() {
	default
	eautoreconf -fi
}
