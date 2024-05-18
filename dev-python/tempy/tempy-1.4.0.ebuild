# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="A simple, visually pleasing weather report in your terminal"
HOMEPAGE="https://github.com/noprobelm/tempy"
SRC_URI="https://github.com/noprobelm/tempy/archive/fb0db08.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/tempy-fb0db0841e097de4ed819066a45933748172e02a"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
# We need https://github.com/darrenburns/ward, which is not in GURU, gentoo, or any overlay I could find.
# When I have more time, I will write the ebuild and remove this.

RDEPEND="
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

pkg_postinst() {
	elog By default, tempy is using the API key of the developper by making requests throught their proxy server.
	elog You can register your own API key at https://www.weatherapi.com, and store it in '$HOME/.config/tempyrc'.
}
