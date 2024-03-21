# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_10 )

inherit distutils-r1

DESCRIPTION="Tool/library for transforming/analyzing cluster configuration formats"
HOMEPAGE="https://pagure.io/clufter"
SRC_URI="https://pagure.io/${PN}/archive/v${PV}/${PN}-v${PV}.tar.gz"

S="${WORKDIR}/${PN}-v${PV}"

SLOT="0"
LICENSE="GPL-2+"
KEYWORDS="~amd64 ~x86"

DOCS=( __root__/README )

DEPEND="dev-python/lxml
		dev-libs/libxml2"

src_compile() {
	# Build native extension first
	pushd "${S}/__root__/ccs-flatten" || die
	emake
	popd || die

	distutils-r1_src_compile
}
