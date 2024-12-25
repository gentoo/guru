# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="GTK3-based greeter for greetd written in python "
HOMEPAGE="https://github.com/nwg-piotr/nwg-hello"
SRC_URI="https://github.com/nwg-piotr/nwg-hello/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	x11-libs/gtk+:3
	gui-libs/gtk-layer-shell[introspection]
	gui-libs/greetd
	|| ( gui-wm/hyprland gui-wm/sway )
"
# gui-wm/swayfx)

DEPEND="${RDEPEND}"

python_install_all() {
	# dodir /etc/nwg-hello
	insinto /etc/nwg-hello
	doins nwg-hello-default.json
	doins nwg-hello-default.css
	doins hyprland.conf
	doins sway-config
	doins README
	# dodir /usr/share/nwg-hello
	insinto /usr/share/nwg-hello
	doins nwg.jpg
	doins img/*

	# dodir /var/cache/nwg-hello
	# insinto /var/cache/nwg-hello
	# doins cache.json

	dodoc README.md

	distutils-r1_python_install_all
}
