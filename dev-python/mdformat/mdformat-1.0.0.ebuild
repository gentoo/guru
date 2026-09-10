# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="CommonMark compliant Markdown formatter"
HOMEPAGE="
	https://github.com/hukkin/mdformat
	https://pypi.org/project/mdformat/
"
SRC_URI="
	https://github.com/hukkin/${PN}/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="
	>=dev-python/markdown-it-py-1[${PYTHON_USEDEP}]
	<dev-python/markdown-it-py-5[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_test() {
	# read_toml_opts() caches per directory, recycled tmp dirs poison the cache
	epytest -o tmp_path_retention_count=3 -o tmp_path_retention_policy=all
}
