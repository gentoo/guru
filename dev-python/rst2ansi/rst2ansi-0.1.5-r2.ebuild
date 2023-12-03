# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Render reStructuredText documents to the terminal"
HOMEPAGE="
	https://pypi.org/project/rst2ansi/
	https://github.com/Snaipe/python-rst2ansi
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
