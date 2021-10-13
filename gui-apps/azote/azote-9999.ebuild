# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1 desktop

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
IUSE="simple-colorpicker imagemagick wayland X yaml"

RDEPEND="
	dev-cpp/gtkmm:3.0
	dev-python/pillow
	dev-python/pygobject:3=
	dev-python/send2trash
	simple-colorpicker? (
		X? (
			media-gfx/maim
			x11-misc/slop
		)
		wayland? (
			gui-apps/grim
			gui-apps/slurp
		)
	)
	imagemagick? (
		media-gfx/imagemagick[jpeg,png,svg,X?]
	)
	wayland? (
		gui-apps/swaybg
		gui-apps/wlr-randr
	)
	X? (
		media-gfx/feh
		x11-apps/xrandr
	)
	yaml? ( dev-python/pyyaml )
"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

python_install_all() {
	distutils-r1_python_install_all

	cd "${S}"

	dobin dist/azote
	domenu dist/azote.desktop

	insinto /usr/share/azote
	doins dist/azote.svg dist/indicator_{active,attention}.png
	insinto /usr/share/licenses/azote
	doins LICENSE-COLORTHIEF
}
