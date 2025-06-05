# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit edo optfeature python-single-r1 xdg

DESCRIPTION="A simple GOG client for Linux"
HOMEPAGE="https://github.com/sharkwouter/minigalaxy"
SRC_URI="https://github.com/sharkwouter/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

# x11-libs/gdk-pixbuf[jpeg] dependency for thumbnails in library entries
# x11-libs/libnotify dependency in minigalaxy/ui/gtk.py
RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		>=dev-python/requests-2.0.0[${PYTHON_USEDEP}]
		dev-python/pygobject:3[${PYTHON_USEDEP}]
	')
	app-arch/unzip
	>=net-libs/webkit-gtk-2.6:4.1[introspection]
	>=x11-libs/gtk+-3[introspection]
	x11-libs/gdk-pixbuf[introspection,jpeg]
	x11-libs/libnotify[introspection]
	x11-misc/xdg-utils
"
# sys-devel/gettext dependency in scripts/compile-translation.py
BDEPEND="
	${PYTHON_DEPS}
	test? (
		$(python_gen_cond_dep '
			dev-python/simplejson[${PYTHON_USEDEP}]
		')
	)
	sys-devel/gettext
"

src_compile() {
	edo "${EPYTHON}" setup.py build
}

src_test() {
	eunittest tests
}

src_install() {
	edo "${EPYTHON}" setup.py install --root="${D}" --prefix="${EPREFIX}/usr"
	python_optimize
	dodoc README.md CHANGELOG.md
}

pkg_postinst() {
	xdg_pkg_postinst

	optfeature "choosing the language of Windows games before installation" app-arch/innoextract
	optfeature "running games with system dosbox" games-emulation/dosbox
	optfeature "running games with system scummvm" games-engines/scummvm
	optfeature "running games with system wine" virtual/wine
}
