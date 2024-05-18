# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Sphinx extension to add a warning banner"
HOMEPAGE="
	https://pypi.org/project/sphinx-version-warning/
	https://github.com/humitos/sphinx-version-warning
"
SRC_URI="https://github.com/humitos/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/sphinx[${PYTHON_USEDEP}]"

# TODO: enable in next release
#distutils_enable_sphinx docs \
#	dev-python/sphinx-autoapi \
#	dev-python/sphinx-prompt \
#	dev-python/sphinx-tabs \
#	dev-python/sphinx-rtd-theme \
#	dev-python/sphinxemoji
