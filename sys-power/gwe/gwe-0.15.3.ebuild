# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit xdg meson python-single-r1

DESCRIPTION="NVIDIA settings alternative with overclocking, fan control, and information"
HOMEPAGE="https://gitlab.com/leinardi/gwe"
SRC_URI="https://gitlab.com/leinardi/gwe/-/archive/${PV}/${P}.tar.gz"

KEYWORDS="~amd64"
SLOT="0"
LICENSE="GPL-3"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
		${PYTHON_DEPS}
		dev-libs/gobject-introspection
		dev-libs/libappindicator:3
		dev-libs/libdazzle

		$(python_gen_cond_dep '
			dev-python/injector[${PYTHON_USEDEP}]
			dev-python/matplotlib[${PYTHON_USEDEP}]
			dev-python/peewee[${PYTHON_USEDEP}]
			dev-python/py3nvml[${PYTHON_USEDEP}]
			dev-python/pygobject:3[${PYTHON_USEDEP}]
			dev-python/python-xlib[${PYTHON_USEDEP}]
			dev-python/pyxdg[${PYTHON_USEDEP}]
			dev-python/requests[${PYTHON_USEDEP}]
			dev-python/Rx[${PYTHON_USEDEP}]
		')
"
DEPEND="${RDEPEND}"
BDEPEND="
		${RDEPEND}
		dev-libs/appstream-glib
		virtual/pkgconfig
"

src_prepare() {
	# Disable post-inst script – let the ebuild handle it
	sed -i meson.build \
		-e "s:meson.add_install_script('scripts/meson_post_install.py')::g" \
		|| die

	default
}

src_install() {
	meson_src_install
	python_optimize
}
