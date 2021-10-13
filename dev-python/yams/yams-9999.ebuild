# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1 systemd

DESCRIPTION="A Last.FM scrobbler for MPD (Yet Another Mpd Scrobbler)"
HOMEPAGE="https://github.com/Berulacks/yams"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/Berulacks/yams.git"
	inherit git-r3
else
	SRC_URI="https://github.com/Berulacks/yams/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/python-mpd[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"
RDEPEND="
	media-sound/mpd
	${DEPEND}
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
