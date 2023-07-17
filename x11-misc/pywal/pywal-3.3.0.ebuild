# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools

PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="A tool that generates color schemes from images"
HOMEPAGE="https://github.com/dylanaraps/pywal"
SRC_URI="https://github.com/dylanaraps/pywal/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="feh nitrogen"

RDEPEND="feh? ( media-gfx/feh )
nitrogen? ( x11-misc/nitrogen )"

DEPEND="${RDEPEND}
	media-gfx/imagemagick[jpeg]"

src_compile() {
	distutils-r1_src_compile
}

src_install() {
	distutils-r1_src_install

	insinto /usr/share/licenses/${PF}
	doins LICENSE.md
}
