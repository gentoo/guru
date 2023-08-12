# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Binding for Pango, to use with Manim."
HOMEPAGE="https://github.com/ManimCommunity/ManimPango https://pypi.org/project/manimpango"
SRC_URI="https://github.com/ManimCommunity/ManimPango/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="x11-libs/pango"
DEPEND="${BDEPEND}"

src_prepare() {
	# The tests always fails (ManimPango has to be installed for them to work)
	rm -rf "${S}/tests"
	distutils-r1_src_prepare
}
