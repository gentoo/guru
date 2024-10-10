# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="sphinx"
DOCS_DIR="docs/source"
DOCS_DEPEND="
	dev-python/sphinx-rtd-theme
"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 docs

DESCRIPTION="Typing speed test in terminal"
HOMEPAGE="https://github.com/Mithil467/mitype https://pypi.org/project/mitype/"
SRC_URI="https://github.com/Mithil467/mitype/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="
	dev-python/versioneer[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
