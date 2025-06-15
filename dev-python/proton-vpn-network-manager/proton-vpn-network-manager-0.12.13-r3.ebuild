# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 linux-info

DESCRIPTION="Proton VPN Network Manager handler"
HOMEPAGE="https://github.com/ProtonVPN/python-proton-vpn-network-manager"
SRC_URI="https://github.com/ProtonVPN/python-proton-vpn-network-manager/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/python-${P}"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-python/pytest-asyncio[${PYTHON_USEDEP}] )"

RDEPEND="
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/proton-core[${PYTHON_USEDEP}]
	dev-python/proton-vpn-api-core[${PYTHON_USEDEP}]
	dev-python/proton-vpn-local-agent[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
	net-misc/networkmanager[introspection]
	net-vpn/networkmanager-openvpn
"

CONFIG_CHECK="~DUMMY ~WIREGUARD"

PATCHES=(
	"${FILESDIR}/${P}-fix-networkmanager-plugin-loading.patch"
	"${FILESDIR}/${P}-remove-call-to-apt.patch"
)

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare
	sed -i "/--cov/d" setup.cfg || die
}

python_test() {
	# VPN connection cannot be tested within sandbox
	local EPYTEST_IGNORE=( tests/unit/core/test_networkmanager.py )

	XDG_RUNTIME_DIR="${T}/python_test" epytest
}
