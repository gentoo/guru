# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )

inherit meson python-single-r1

DESCRIPTION="An RSS/Atom parser, because there's nothing else out there."
HOMEPAGE="https://gitlab.com/gabmus/syndication-domination"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/gabmus/syndication-domination.git"
else
	KEYWORDS="~amd64"
	SRC_URI="https://gitlab.com/gabmus/syndication-domination/-/archive/${PV}/${P}.tar.bz2"
	#required for gfeeds
	PATCHES="${FILESDIR}/gfeeds-2.2.0-blueprint-compiler-fix.patch"
fi

LICENSE="AGPL-3"
SLOT="0"
IUSE="debug json-binary +python"
REQUIRED_USE="
	python? ( ${PYTHON_REQUIRED_USE} )
	!python? ( json-binary )
"
DEPEND="
	app-text/htmltidy
	dev-libs/libfmt
	dev-libs/pugixml
	python? (
		$(python_gen_cond_dep '
			dev-python/cython[${PYTHON_USEDEP}]
			dev-python/pybind11[${PYTHON_USEDEP}]
		')
	)

"
RDEPEND="
	${DEPEND}
	python? ( ${PYTHON_DEPS} )
"

src_configure() {
	local emesonargs=(
		--prefix=/usr
		-DHTML_SUPPORT=true
		$(meson_use python PYTHON_BINDINGS)
		$(meson_use json-binary TO_JSON_BINARY)
	)
	meson_src_configure
}

src_compile() {
	meson_src_compile
}

src_install() {
	meson_src_install
}
