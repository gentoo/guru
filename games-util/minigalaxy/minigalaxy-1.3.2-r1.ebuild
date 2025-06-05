# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit edo python-single-r1 optfeature xdg

DESCRIPTION="A simple GOG client for Linux"
HOMEPAGE="https://github.com/sharkwouter/minigalaxy"
SRC_URI="https://github.com/sharkwouter/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="test"
# restricted unconditionally due to failures
RESTRICT="test"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		>=dev-python/requests-2.0.0[${PYTHON_USEDEP}]
		dev-python/pygobject:3[${PYTHON_USEDEP}]
	')
	>=net-libs/webkit-gtk-2.6:4.1
	>=x11-libs/gtk+-3
"
BDEPEND="
	test? (
		$(python_gen_cond_dep '
			dev-python/simplejson[${PYTHON_USEDEP}]
		')
	)
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_test() {
	eunittest
}

src_install() {
	# workaround for legacy setup.py
	edo ${EPYTHON} setup.py install --root="${D}" --prefix="${EPREFIX}/usr" --optimize=1
	python_optimize
}

pkg_postinst() {
	xdg_pkg_postinst

	optfeature "running games with system dosbox" games-emulation/dosbox
	optfeature "running games with system scummvm" games-engines/scummvm
}
