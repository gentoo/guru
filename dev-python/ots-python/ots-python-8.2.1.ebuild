# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )

inherit distutils-r1

DESCRIPTION="A Python wrapper for OpenType Sanitizer"
HOMEPAGE="
	https://github.com/googlefonts/ots-python
	https://pypi.org/project/opentype-sanitizer/
"
SRC_URI="https://github.com/googlefonts/ots-python/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="0"

RDEPEND=">=dev-util/ots-${PV}"

PATCHES=( "${FILESDIR}/${PN}-8.1.4-ots-sanitize.patch" )

distutils_enable_tests pytest

src_prepare() {
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV/_p/.post}"
	mkdir -p src/c/ots || die
	default
}
