# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1

DESCRIPTION="Python dictionary with Jinja2 expansion"
HOMEPAGE="
	https://github.com/xsuchy/templated-dictionary/
	https://pypi.org/project/templated-dictionary/
"
SRC_URI="https://github.com/xsuchy/templated-dictionary/archive/refs/tags/python-${P}-1.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-python-${P}-1"

SLOT="0"
LICENSE="GPL-2+"
KEYWORDS="~amd64"

RDEPEND="dev-python/jinja[${PYTHON_USEDEP}]"
