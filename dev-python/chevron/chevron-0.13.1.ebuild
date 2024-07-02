# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/noahmorrison/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/noahmorrison/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="A Python implementation of mustache"
HOMEPAGE="https://github.com/noahmorrison/chevron"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	${PYTHON_DEPS}
"

distutils_enable_tests unittest
