# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=(python3_5 python3_6)

inherit distutils-r1

DESCRIPTION="Metadata Anonymisation Toolkit: handy tool to trash your metadata"
HOMEPAGE="https://0xacab.org/jvoisin/mat2"
LICENSE="LGPL-3"
SLOT="0"
SRC_URI="https://0xacab.org/jvoisin/mat2/-/archive/${PV}/${P}.tar.gz"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	media-libs/mutagen:*
	dev-python/pygobject:3
	dev-python/pycairo:*
"
RDEPEND="${DEPEND}"
