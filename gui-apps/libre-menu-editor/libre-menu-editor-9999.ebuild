# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..15} )
inherit python-single-r1 xdg

DESCRIPTION="A libre menu editor for desktop entries"
HOMEPAGE="https://codeberg.org/libre-menu-editor/libre-menu-editor"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/libre-menu-editor/libre-menu-editor"
else
	SRC_URI="https://codeberg.org/libre-menu-editor/libre-menu-editor/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
# this ebuild does not install binaries
RESTRICT="binchecks strip"

RDEPEND="
	${PYTHON_DEPS}
	>=gui-libs/libadwaita-1.2.0
	gui-libs/gtk:4
	$(python_gen_cond_dep '
		dev-python/pygobject:3[${PYTHON_USEDEP}]
	')
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_compile() {
	:
}

src_install() {
	emake DESTDIR="${ED}" install

	rm "${ED}/usr/share/libre-menu-editor/COPYING" || die
	python_fix_shebang "${ED}/usr/share/libre-menu-editor/main.py"
	python_optimize "${ED}/usr/share/libre-menu-editor"
	fperms +x "/usr/share/libre-menu-editor/main.py"
	dosym ../share/libre-menu-editor/main.py /usr/bin/libre-menu-editor

	sed -i -e "s|Exec=.*|Exec=libre-menu-editor|" \
		"${ED}/usr/share/applications/page.codeberg.libre_menu_editor.LibreMenuEditor.desktop" || die
}
