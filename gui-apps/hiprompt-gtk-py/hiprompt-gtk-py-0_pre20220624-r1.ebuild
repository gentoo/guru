# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
inherit meson python-single-r1 xdg

DESCRIPTION="GTK+ Himitsu prompter for Wayland"
HOMEPAGE="https://git.sr.ht/~sircmpwn/hiprompt-gtk-py"
EGIT_COMMIT="f74499302bdd6558d4644c25e15c9b5c482270ea"
SRC_URI="https://git.sr.ht/~sircmpwn/hiprompt-gtk-py/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${EGIT_COMMIT}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~riscv"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/pygobject[${PYTHON_USEDEP}]')
	x11-libs/gtk+:3[introspection]
	>=gui-libs/gtk-layer-shell-0.5.0[introspection]
"
DEPEND="${RDEPEND}"

src_prepare() {
	default

	sed -i "s;@PYTHON@;/usr/bin/${EPYTHON};g" hiprompt_gtk/hiprompt-gtk.in || die
}
