# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )

inherit desktop distutils-r1 git-r3 xdg

DESCRIPTION="Install and manage GE-Proton, Luxtorpeda & more for Steam Lutris and Heroic."
HOMEPAGE="https://davidotek.github.io/protonup-qt/"
EGIT_REPO_URI="https://github.com/DavidoTek/ProtonUp-Qt.git"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	dev-python/pyaml[${PYTHON_USEDEP}]
	dev-python/pyside[dbus,gui,uitools,widgets,${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/steam[${PYTHON_USEDEP}]
	dev-python/vdf[${PYTHON_USEDEP}]
	dev-python/zstandard[${PYTHON_USEDEP}]
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
