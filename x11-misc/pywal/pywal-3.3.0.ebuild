# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 optfeature

DESCRIPTION="Tool that generates color schemes from images"
HOMEPAGE="https://github.com/dylanaraps/pywal"
SRC_URI="https://github.com/dylanaraps/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="media-gfx/imagemagick[jpeg]"

pkg_postinst() {
	optfeature "setting wallpaper support" \
		media-gfx/feh \
		x11-misc/hsetroot \
		x11-misc/nitrogen
}
