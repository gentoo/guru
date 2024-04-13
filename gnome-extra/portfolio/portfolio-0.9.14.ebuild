# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..12} )

inherit gnome2-utils meson python-single-r1 xdg

DESCRIPTION="A minimalist file manager for those who want to use Linux mobile devices"
HOMEPAGE="https://github.com/tchx84/Portfolio"
SRC_URI="https://github.com/tchx84/Portfolio/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
RESTRICT="test"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	gui-libs/libhandy
	x11-libs/gtk+
"

S="${WORKDIR}"/Portfolio-"${PV}"

src_prepare() {
	default
	# shebang fixing craziness
	sed -i -e 's|\@PYTHON\@|/usr/bin/python|' src/dev.tchx84.Portfolio.in
}

src_install() {
	meson_src_install
	python_optimize "${ED}"/usr/lib/
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
