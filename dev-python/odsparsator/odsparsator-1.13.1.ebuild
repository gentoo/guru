# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Generate a JSON file from an OpenDocument Format .ods file."
HOMEPAGE="https://github.com/jdum/odsparsator"
SRC_URI="https://github.com/jdum/odsparsator/archive/refs/tags/v${PV}.tar.gz -> odsparsator-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

RDEPEND="
	>=dev-python/odfdo-3.14.0[${PYTHON_USEDEP}]
"

BDEPEND="
	doc? (
		>=dev-python/sphinx-7.0[${PYTHON_USEDEP}]
		>=dev-python/myst-parser-4.0.1[${PYTHON_USEDEP}]
	)
"
