# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 virtualx

DESCRIPTION="GTK4 frontend for rawji, interactive Fujifilm RAF conversion"
HOMEPAGE="https://github.com/p5k369/grawji"
SRC_URI="https://github.com/p5k369/grawji/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/rawji[${PYTHON_USEDEP}]
	gui-libs/gtk:4[introspection]
	gui-libs/libadwaita:1[introspection]
	media-libs/gexiv2[introspection]
"

EPYTEST_PLUGINS=()

EPYTEST_IGNORE=(
	# the pin is replaced by dev-python/rawji here.
	tests/test_rawji_pin.py
)

distutils_enable_tests pytest

src_prepare() {
	# rawji is provided by dev-python/rawji
	sed -i 's|"rawji @ git+[^"]*"|"rawji"|' pyproject.toml || die
	default
}

src_test() {
	virtx distutils-r1_src_test
}
