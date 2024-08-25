# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )
PYTHON_REQ_USE="sqlite"
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_IN_SOURCE_BUILD=
inherit distutils-r1

DESCRIPTION="Tool to extract passwords from Mozilla (Firefox, Thunderbird, etc.) profiles"
HOMEPAGE="https://github.com/Unode/firefox_decrypt"
SRC_URI="https://github.com/unode/${PN/-/_}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN/-/_}-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-libs/nss"
BDEPEND="
	$(python_gen_cond_dep 'dev-python/setuptools-scm[${PYTHON_USEDEP}]')
"

distutils_enable_tests setup.py

src_prepare() {
	rm tests/version.t || die
	distutils-r1_src_prepare
}

python_prepare() {
	python_fix_shebang "${S}"/tests
}

python_test() {
	cd "${S}"/tests || die
	${EPYTHON} run_all -v || die
}
