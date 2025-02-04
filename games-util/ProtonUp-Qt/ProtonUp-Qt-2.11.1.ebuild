# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit desktop distutils-r1 xdg

DESCRIPTION="Install and manage GE-Proton, Luxtorpeda & more for Steam Lutris and Heroic."
HOMEPAGE="https://davidotek.github.io/protonup-qt/"

SRC_URI="
	https://github.com/DavidoTek/ProtonUp-Qt/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pyaml-6.0[${PYTHON_USEDEP}]
	>=dev-python/pyside-6.3.0[dbus,gui,uitools,widgets,${PYTHON_USEDEP}]
	>=dev-python/pyxdg-0.27[${PYTHON_USEDEP}]
	>=dev-python/requests-2.27.0[${PYTHON_USEDEP}]
	>=dev-python/steam-1.6.1[${PYTHON_USEDEP}]
	>=dev-python/vdf-4.0[${PYTHON_USEDEP}]
	>=dev-python/zstandard-0.19.0[${PYTHON_USEDEP}]
"

PATCHES=(
	"${FILESDIR}/${P}-add-entrypoint.patch"
)

distutils_enable_tests pytest

src_prepare() {
	# execute entry point instead
	sed -i "/^Exec=/s/net.davidotek.pupgui2/${PN}/" share/applications/net.davidotek.pupgui2.desktop || die
	distutils-r1_src_prepare
}

src_install() {
	distutils-r1_src_install
	domenu share/applications/net.davidotek.pupgui2.desktop
	for size in 64 128 256; do
		doicon -s ${size} share/icons/hicolor/${size}x${size}/apps/net.davidotek.pupgui2.png
	done
}
