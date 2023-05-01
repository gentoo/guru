# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Enum handling for Marshmallow"
HOMEPAGE="https://github.com/justanr/marshmallow_enum"
SRC_URI="https://github.com/justanr/marshmallow_enum/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-python/marshmallow-2.0.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest

src_prepare() {
	sed -e '/addopts/d' -i tox.ini || die
	distutils-r1_src_prepare
}
