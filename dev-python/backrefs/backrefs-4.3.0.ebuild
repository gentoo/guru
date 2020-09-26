# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )

DOCBUILDER="mkdocs"
DOCDEPEND="
		~dev-python/mkdocs-material-4.6.3
		dev-python/pyspelling
"

inherit distutils-r1 docs

DESCRIPTION="Wrapper around re or regex that adds additional back references"
HOMEPAGE="
	https://github.com/facelessuser/backrefs
	https://pypi.org/project/backrefs
"
SRC_URI="https://github.com/facelessuser/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/regex[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
