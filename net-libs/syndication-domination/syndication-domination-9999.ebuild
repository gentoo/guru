# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="An RSS/Atom parser, because there's nothing else out there."
HOMEPAGE="https://gitlab.com/gabmus/syndication-domination"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/gabmus/syndication-domination.git"
else
	KEYWORDS="~amd64"
	SRC_URI="https://gitlab.com/gabmus/syndication-domination/-/archive/${PV}/${P}.tar.bz2"
fi

LICENSE="AGPL-3"
SLOT="0"
IUSE="debug json-binary +python"
REQUIRED_USE="
	^^ ( python json-binary )
"
DEPEND="
	app-text/htmltidy
	dev-libs/libfmt
	dev-libs/pugixml
	python? (
		>=dev-lang/python-3.11
		dev-python/pybind11
	)
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local emesonargs=(
		--buildtype $(usex debug debug release)
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
