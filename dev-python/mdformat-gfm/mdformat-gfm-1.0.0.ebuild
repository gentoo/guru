# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=flit
inherit distutils-r1

DESCRIPTION="Mdformat plugin for GitHub Flavored Markdown compatibility"
HOMEPAGE="
	https://github.com/hukkin/mdformat-gfm
	https://pypi.org/project/mdformat-gfm/
"
SRC_URI="
	https://github.com/hukkin/${PN}/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="
	>=dev-python/mdformat-0.7.5[${PYTHON_USEDEP}]
	dev-python/markdown-it-py[${PYTHON_USEDEP}]
	>=dev-python/mdit-py-plugins-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/wcwidth-0.2.13[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
