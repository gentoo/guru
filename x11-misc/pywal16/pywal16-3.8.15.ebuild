# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 optfeature

DESCRIPTION="16 colors fork of pywal"
HOMEPAGE="https://github.com/eylles/pywal16"
SRC_URI="https://github.com/eylles/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-gfx/imagemagick[jpeg]"

distutils_enable_tests unittest

src_prepare() {
	distutils-r1_src_prepare

	sed \
		-e "/data_files/s|'man/man1'|'share/man/man1'|g" \
		-i setup.py || die
}

pkg_postinst() {
	optfeature "setting wallpaper support" \
		media-gfx/feh \
		x11-misc/hsetroot \
		x11-misc/nitrogen
}
