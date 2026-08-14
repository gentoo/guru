# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

EGIT_COMMIT="5549fdb93028549c2bab8abe963f1a91c50b5368"
DESCRIPTION="Fujifilm RAF conversion using the camera's own engine over USB"
HOMEPAGE="https://github.com/pinpox/rawji"
SRC_URI="https://github.com/pinpox/rawji/archive/${EGIT_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pyusb[${PYTHON_USEDEP}]"
