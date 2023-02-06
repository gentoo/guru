# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Fetch location and size of physical screens."
HOMEPAGE="https://github.com/rr-/screeninfo https://pypi.org/project/screeninfo"
SRC_URI="https://github.com/rr-/screeninfo/archive/refs/tags/${PV}.tar.gz -> v${PV}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
BDEPEND="dev-python/poetry-core[${PYTHON_USEDEP}]"
DEPEND="${BDEPEND}"

distutils_enable_tests pytest
