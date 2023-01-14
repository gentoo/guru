# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 )
inherit font python-any-r1

DESCRIPTION="A IBM 3270 Terminal font in a modern format"
HOMEPAGE="https://github.com/rbanffy/3270font"
SRC_URI="https://github.com/rbanffy/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD CC-BY-SA-3.0 GPL-3 OFL"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RESTRICT="test"
PROPERTIES="test_network"

BDEPEND="
	${PYTHON_DEPS}
	media-gfx/fontforge
	test? (
		$(python_gen_any_dep '
			dev-python/ipdb[${PYTHON_USEDEP}]
			dev-python/pillow[${PYTHON_USEDEP}]
			dev-util/gftools[${PYTHON_SINGLE_USEDEP}]
			media-gfx/fontbakery[${PYTHON_USEDEP}]
		')
	)
"

DOCS=( CHANGELOG.md README.md  )
HTML_DOCS=( "DESCRIPTION.en_us.html" )

PATCHES=(
	"${FILESDIR}/remove-useless-tests.patch"
	"${FILESDIR}/${PN}-2.3.0-correctly-pass-options.patch"
)

FONT_S="${S}/build"
FONT_SUFFIX="otf ttf pfm woff"

python_check_deps() {
	use test || return 0
	python_has_version -b "dev-python/ipdb[${PYTHON_USEDEP}]" &&
	python_has_version -b "dev-python/pillow[${PYTHON_USEDEP}]" &&
	python_has_version -b "dev-util/gftools[${PYTHON_USEDEP}]" &&
	python_has_version -b "media-gfx/fontbakery[${PYTHON_USEDEP}]"
}

src_compile() {
	emake font
}

src_test() {
	emake test
	emake fbchecks
}
