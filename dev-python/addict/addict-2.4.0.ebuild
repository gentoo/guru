# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} python3_13t )

inherit distutils-r1

DESCRIPTION="The Python Dict that's better than heroin"
HOMEPAGE="https://github.com/mewwts/addict https://pypi.org/project/addict/"
SRC_URI="https://github.com/mewwts/addict/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
