# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="MKDocs plugin for rendering swagger & openapi files"
HOMEPAGE="
	https://pypi.org/project/mkdocs-render-swagger-plugin/
	https://github.com/bharel/mkdocs-render-swagger-plugin
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/mkdocs"
