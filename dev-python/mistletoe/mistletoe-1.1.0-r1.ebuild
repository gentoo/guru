# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="A fast, extensible and spec-compliant Markdown parser in pure Python."
HOMEPAGE="https://github.com/miyuchina/mistletoe"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="test? ( dev-python/parameterized[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
