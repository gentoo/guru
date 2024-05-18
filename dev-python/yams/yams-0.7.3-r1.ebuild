# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 systemd

DESCRIPTION="Yet Another MPD Scrobbler (for Last.FM)"
HOMEPAGE="https://github.com/Berulacks/yams"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/Berulacks/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/Berulacks/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/python-mpd2[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	media-sound/mpd
"

python_install_all() {
	systemd_douserunit yams.service

	distutils-r1_python_install_all
}
