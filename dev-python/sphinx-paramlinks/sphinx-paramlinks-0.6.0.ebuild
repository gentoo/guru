# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Allows param links in Sphinx function/method descriptions to be linkable"
HOMEPAGE="https://github.com/sqlalchemyorg/sphinx-paramlinks https://pypi.org/project/sphinx-paramlinks/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/docutils
	dev-python/sphinx
"
