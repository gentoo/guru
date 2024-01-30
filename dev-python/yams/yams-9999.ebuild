# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 )
inherit distutils-r1 systemd

DESCRIPTION="Yet Another MPD Scrobbler (for Last.FM)"
HOMEPAGE="https://github.com/Berulacks/yams"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/Berulacks/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/Berulacks/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
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

python_prepare_all() {
	# Change application name so the .egg-info directory has the
	# same name as the Python site-package one for consistency
	sed -e "s/YAMScrobbler/yams/" -i setup.py || die

	distutils-r1_python_prepare_all
}

python_install_all() {
	systemd_douserunit yams.service

	distutils-r1_python_install_all
}
