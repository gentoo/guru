# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Generate an OpenDocument Format .ods file from a .json or .yaml file."
HOMEPAGE="https://github.com/jdum/odsgenerator"
SRC_URI="https://github.com/jdum/odsgenerator/archive/refs/tags/v${PV}.tar.gz -> odsgenerator-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

RDEPEND="
	>=dev-python/odfdo-3.7.7[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0.3[${PYTHON_USEDEP}]
"

BDEPEND="
	doc? (
		>=dev-python/sphinx-7.0[${PYTHON_USEDEP}]
		>=dev-python/myst-parser-4.0.1[${PYTHON_USEDEP}]
	)
"
