# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit meson python-single-r1 xdg

DESCRIPTION="graphical frontend for managing a Himitsu key store"
HOMEPAGE="https://git.sr.ht/~martijnbraam/keyring"
SRC_URI="https://git.sr.ht/~martijnbraam/keyring/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/keyring-${PV}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/pygobject[${PYTHON_USEDEP}]')
	x11-libs/gtk+:3[introspection]
	gui-libs/libhandy:=
"
DEPEND="${RDEPEND}"

src_prepare() {
	default

	sed -i "s;@PYTHON@;/usr/bin/${EPYTHON};g" himitsu_gtk/himitsu-keyring.in || die
}
