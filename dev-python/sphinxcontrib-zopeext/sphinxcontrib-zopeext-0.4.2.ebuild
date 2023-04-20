# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1 pypi

DESCRIPTION="Sphinx extension for using Zope interfaces"
HOMEPAGE="https://github.com/sphinx-contrib/zopeext"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/importlib-metadata[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]
"

src_unpack() {
	default
	sed -i -e "s/pdm-backend/pdm-pep517/" "${S}/pyproject.toml" || die
	sed -i -e "s/pdm\.backend/pdm.pep517.api/" "${S}/pyproject.toml" || die
}
