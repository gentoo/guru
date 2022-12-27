# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Python implementation of Dropbox's realistic password strength estimator"
HOMEPAGE="https://github.com/dwolfhub/zxcvbn-python"
SRC_URI="https://github.com/dwolfhub/${PN}-python/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-python-${PV}"

distutils_enable_tests pytest
