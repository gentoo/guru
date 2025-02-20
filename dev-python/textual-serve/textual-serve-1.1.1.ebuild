# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

HASH="6d13319e689766f41cb6bd589379d4a692cae081"
DESCRIPTION="Serve Textual apps locally"
HOMEPAGE="https://github.com/Textualize/textual-serve https://pypi.org/project/textual-serve/"
SRC_URI="https://github.com/Textualize/${PN}/archive/${HASH}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${HASH}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/aiohttp-3.9.5[${PYTHON_USEDEP}]
	>=dev-python/jinja2-3.1.4[${PYTHON_USEDEP}]
	>=dev-python/textual-0.66.0[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
