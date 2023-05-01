# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
inherit gnome2-utils meson python-single-r1 xdg

DESCRIPTION="An app for Reddit"
HOMEPAGE="https://giara.gabmus.org https://gitlab.gnome.org/World/giara"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.gnome.org/World/${PN}.git"
else
	SRC_URI="https://gitlab.gnome.org/World/${PN}/-/archive/${PV}/${P}.tar.bz2"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3+"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	dev-libs/glib:2
	dev-libs/gobject-introspection[${PYTHON_SINGLE_USEDEP}]
	gui-libs/gtk:4[introspection(+)]
	gui-libs/gtksourceview:5[introspection(+)]
	gui-libs/libadwaita:1[introspection(+)]
	$(python_gen_cond_dep '
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/mistune[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/praw[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
	')
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/blueprint-compiler
	sys-devel/gettext
"

src_prepare() {
	default

	# fix broken shebang
	sed "s|py_installation.full_path()|'${PYTHON}'|" -i bin/meson.build || die
}

# skip AppStream test
src_test() {
:
}

src_install() {
	meson_src_install
	python_optimize
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
