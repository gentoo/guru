# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=true
DISTUTILS_USE_PEP517=setuptools

PYTHON_COMPAT=( python3_{11..13} )

inherit desktop distutils-r1

DESCRIPTION="Proton VPN GTK app"
HOMEPAGE="https://github.com/ProtonVPN/proton-vpn-gtk-app"
SRC_URI="https://github.com/ProtonVPN/proton-vpn-gtk-app/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="
	$(python_gen_cond_dep '
		dev-python/dbus-python[${PYTHON_USEDEP}]
		dev-python/distro[${PYTHON_USEDEP}]
		dev-python/packaging[${PYTHON_USEDEP}]
		dev-python/proton-core[${PYTHON_USEDEP}]
		dev-python/proton-keyring-linux[${PYTHON_USEDEP}]
		dev-python/proton-vpn-api-core[${PYTHON_USEDEP}]
		dev-python/proton-vpn-local-agent[${PYTHON_USEDEP}]
		dev-python/proton-vpn-network-manager[${PYTHON_USEDEP}]
		dev-python/pycairo[${PYTHON_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
	')
"

PATCHES=( "${FILESDIR}/${P}-remove-call-to-apt.patch" )

src_install() {
	distutils-r1_src_install

	doicon rpmbuild/SOURCES/proton-vpn-logo.svg
	domenu rpmbuild/SOURCES/protonvpn-app.desktop
}
