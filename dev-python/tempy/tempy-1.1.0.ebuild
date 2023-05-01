# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="A simple, visually pleasing weather report in your terminal"
HOMEPAGE="https://github.com/noprobelm/tempy"
SRC_URI="https://github.com/noprobelm/tempy/archive/26f13ed.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/tempy-26f13ed15bc1a4458976572ccdc60399ca5cb123"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/assets.patch"
)

pkg_postinst() {
	elog By default, tempy is using the API key of the developper by making requests throught their proxy server.
	elog You can register your own API key at https://www.weatherapi.com, and store it in '$HOME/.config/tempyrc'.
}
