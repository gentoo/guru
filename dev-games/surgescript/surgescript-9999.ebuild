# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..12} )
DOCS_BUILDER="mkdocs"
DOCS_DEPEND="dev-python/mkdocs-material"

inherit cmake python-any-r1 docs

DESCRIPTION="scripting language made for opensurge"
HOMEPAGE="https://alemart.github.io/surgescript"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/alemart/${PN}.git"
	SLOT="0"
else
	SRC_URI="https://github.com/alemart/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	SLOT="0/$(ver_cut 1-3)"
fi

LICENSE="Apache-2.0"
IUSE="examples static-libs"

DOCS=( CHANGES.md README.md )

src_prepare() {
	cmake_src_prepare

	sed -i -e '/^strict: true$/d' -e '/^google_analytics/d' mkdocs.yml || die
}

src_configure() {
	local mycmakeoptions=(
		-DWANT_STATIC=$(usex static-libs)
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	docs_compile
}

src_install() {
	cmake_src_install

	docompress -x /usr/share/doc/${PF}/examples
	use examples && dodoc -r examples
}
