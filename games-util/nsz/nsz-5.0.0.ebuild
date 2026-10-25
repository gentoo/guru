# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 optfeature

DESCRIPTION="Homebrew compatible NSP/XCI compressor/decompressor"
HOMEPAGE="https://github.com/nicoboss/nsz"
SRC_URI="https://github.com/nicoboss/nsz/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="
	dev-python/enlighten[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/zstandard[${PYTHON_USEDEP}]
"

PATCHES=(
	"${FILESDIR}/nsz-5.0.0-override-the-location-of-the-app-config.patch"
)

pkg_postinst() {
	optfeature "GUI" dev-python/kivy
}
