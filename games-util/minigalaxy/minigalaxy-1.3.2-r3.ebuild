# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit desktop optfeature python-single-r1 xdg

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
BDEPEND="
	${PYTHON_DEPS}
	sys-apps/help2man
	sys-devel/gettext
	test? (
		$(python_gen_cond_dep '
			dev-python/simplejson[${PYTHON_USEDEP}]
		')
	)
"

src_test() {
	eunittest tests
}

src_install() {
	sed -e "s:os.path.dirname(sys.argv\[0\]):'${EPREFIX}/usr/share/':" \
		-e "s:minigalaxy/translations:locale:" \
		-i minigalaxy/paths.py || die

	insinto /usr/share/minigalaxy
	doins -r data/images data/ui data/style.css
	insinto /usr/share/metainfo
	doins data/io.github.sharkwouter.Minigalaxy.metainfo.xml

	help2man -N -s 6 -n "a simple GTK-based GOG Linux client" bin/minigalaxy > minigalaxy.6 || die
	doman minigalaxy.6

	domo data/po/*.po

	local x
	for x in 128 192; do
		doicon -s ${x} data/icons/${x}x${x}/io.github.sharkwouter.Minigalaxy.png
	done

	domenu data/io.github.sharkwouter.Minigalaxy.desktop

	dodoc README.md CHANGELOG.md

	python_domodule minigalaxy
	python_doscript bin/minigalaxy
}

pkg_postinst() {
	xdg_pkg_postinst

	optfeature "choosing the language of Windows games before installation" app-arch/innoextract
	optfeature "running games with system dosbox" games-emulation/dosbox
	optfeature "running games with system scummvm" games-engines/scummvm
	optfeature "running games with system wine" virtual/wine
}
