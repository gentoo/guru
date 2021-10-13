# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/fakefred/${PN}"
case "${PV}" in
	9999)
		inherit git-r3
		;;
	*)
		SRC_URI="${EGIT_REPO_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
		KEYWORDS="~amd64"
esac

PYTHON_COMPAT=( python3_8 )
inherit distutils-r1
distutils_enable_sphinx docs dev-python/sphinx_rtd_theme

DESCRIPTION="Manipulate ASCII art as you would do with raster images"
HOMEPAGE="https://github.com/fakefred/ascim"
LICENSE="MIT"

SLOT="0"
