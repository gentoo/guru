# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit meson python-single-r1

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.gnome.org/jwestman/blueprint-compiler.git"
else
	SRC_URI="https://gitlab.gnome.org/jwestman/blueprint-compiler/-/archive/v${PV}/blueprint-compiler-v${PV}.tar.bz2"
	S="${WORKDIR}/${PN}-v${PV}"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Compiler for Blueprint, a markup language for GTK user interfaces"
HOMEPAGE="https://jwestman.pages.gitlab.gnome.org/blueprint-compiler/"

LICENSE="LGPL-3+"
SLOT="0"

IUSE="doc test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

BDEPEND="
	${PYTHON_DEPS}
	doc? (
		$(python_gen_cond_dep '
			dev-python/sphinx[${PYTHON_USEDEP}]
			dev-python/furo[${PYTHON_USEDEP}]
		')
	)
"

DEPEND="
	test? (
		gui-libs/gtk:4[introspection]
	)
"

RDEPEND="
	${PYTHON_DEPS}
"

src_configure() {
	local emesonargs=(
		$(meson_use doc docs)
	)
	meson_src_configure
}

src_install() {
	use doc && HTML_DOCS=( "${BUILD_DIR}/docs"/* )
	meson_src_install
	python_optimize "${D}/usr/share/${PN}"
	python_fix_shebang "${D}/usr/bin/${PN}"
}
