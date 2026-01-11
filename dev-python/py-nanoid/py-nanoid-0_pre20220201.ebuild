# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

EGIT_COMMIT="99e5b478c450f42d713b6111175886dccf16f156"

DESCRIPTION="Python Nanoid"
HOMEPAGE="https://github.com/puyuan/py-nanoid https://pypi.org/project/nanoid"
SRC_URI="https://github.com/puyuan/py-nanoid/archive/${EGIT_COMMIT}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest
