# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..12} )
DISTUTILS_USE_PEP517=setuptools
inherit desktop distutils-r1 optfeature xdg-utils

DESCRIPTION="wallpaper manager for wlroots compositors"
HOMEPAGE="https://github.com/nwg-piotr/azote"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nwg-piotr/azote"
else
	SRC_URI="https://github.com/nwg-piotr/azote/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3 BSD"
SLOT="0"

RDEPEND="
	dev-cpp/gtkmm:3.0
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pygobject:3=[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/send2trash[${PYTHON_USEDEP}]
"

PATCHES=(
	"${FILESDIR}"/${PN}-1.12.6-pyproject.patch
)

python_install_all() {
	distutils-r1_python_install_all

	cd "${S}"

	domenu dist/azote.desktop

	insinto /usr/share/azote
	doins dist/azote.svg dist/indicator_{active,attention}.png
	insinto /usr/share/licenses/azote
	doins LICENSE-COLORTHIEF
}

pkg_postinst() {
	xdg_desktop_database_update

	optfeature "wayland support" gui-apps/grim gui-apps/slurp gui-apps/swaybg gui-apps/wlr-randr
	optfeature "X support"       media-gfx/feh media-gfx/maim x11-apps/xrandr x11-misc/slop
}
