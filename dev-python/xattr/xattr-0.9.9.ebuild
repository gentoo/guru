# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1 pypi

DESCRIPTION="Python wrapper for extended filesystem attributes"
HOMEPAGE="https://github.com/xattr/xattr"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/cffi-1.0.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

distutils_enable_tests setup.py
