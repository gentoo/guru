# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="Interface to the Unicode Character Database"
HOMEPAGE="https://github.com/simoncozens/youseedee"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
