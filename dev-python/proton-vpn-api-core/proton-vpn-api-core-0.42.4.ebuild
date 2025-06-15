# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Proton AG VPN Core API"
HOMEPAGE="https://github.com/ProtonVPN/python-proton-vpn-api-core"
SRC_URI="https://github.com/ProtonVPN/python-proton-vpn-api-core/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/python-${P}"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-python/pytest-asyncio[${PYTHON_USEDEP}] )"

RDEPEND="
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/distro[${PYTHON_USEDEP}]
	dev-python/proton-core[${PYTHON_USEDEP}]
	dev-python/pynacl[${PYTHON_USEDEP}]
	dev-python/sentry-sdk[${PYTHON_USEDEP}]
"

distutils_enable_sphinx docs
distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare

	sed -i "/--cov/d" setup.cfg || die
}

python_test() {
	# VPN connection cannot be tested within sandbox
	local EPYTEST_IGNORE=(
		tests/connection
		tests/core/refresher
		tests/core/test_{connection,settings,usage}.py
	)

	XDG_RUNTIME_DIR="${T}/python_test" epytest
}
