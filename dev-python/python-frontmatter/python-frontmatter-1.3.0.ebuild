# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 optfeature

DESCRIPTION="Parse and manage posts with YAML (or other) frontmatter"
HOMEPAGE="
	https://github.com/eyeseast/python-frontmatter
	https://pypi.org/project/python-frontmatter/
"
SRC_URI="https://github.com/eyeseast/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="
	dev-python/pyyaml[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/toml[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

pkg_postinst() {
	optfeature "TOML support" dev-python/toml
}
