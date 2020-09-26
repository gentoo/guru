# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1

MY_PN="${PN/-/.}"

DESCRIPTION="Community maintained fork of pdfminer"
HOMEPAGE="https://github.com/pdfminer/pdfminer.six"
MY_GITHUB_AUTHOR="pdfminer"
SRC_URI="https://github.com/${MY_GITHUB_AUTHOR}/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/chardet-3.0[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/sortedcontainers[${PYTHON_USEDEP}]
"

S="${WORKDIR}"/"${MY_PN}-${PV}"

distutils_enable_tests nose
distutils_enable_sphinx docs/source dev-python/sphinx-argparse
