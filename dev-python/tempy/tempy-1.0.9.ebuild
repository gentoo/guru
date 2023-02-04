# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="A simple, visually pleasing weather report in your terminal"
HOMEPAGE="https://github.com/noprobelm/tempy"
SRC_URI="https://github.com/noprobelm/tempy/archive/7a597ee.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/tempy-7a597ee78fc7ba2c4ced041780470f568998f3c1"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
BDEPEND=""
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/assets.patch"
)

pkg_postinst() {
	elog By default, tempy is using the API key of the developper by making requests throught their proxy server.
	elog You can register your own API key at https://www.weatherapi.com, and store it in '$HOME/.config/tempyrc'.
}
