# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_11 )

inherit distutils-r1

DESCRIPTION="A simple code complexity analyser, supports most of the popular languages."
HOMEPAGE="http://www.lizard.ws/"
SRC_URI="https://github.com/terryyin/lizard/archive/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

DEPEND="
	test? (
		dev-python/jinja[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
