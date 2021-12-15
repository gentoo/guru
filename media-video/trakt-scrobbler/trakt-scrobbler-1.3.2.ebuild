# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )
DISTUTILS_USE_SETUPTOOLS=pyproject.toml

inherit distutils-r1 optfeature

DESCRIPTION="Scrobbler for trakt.tv that supports VLC, Plex, MPC-HC, and MPV"
HOMEPAGE="https://github.com/iamkroot/trakt-scrobbler"
SRC_URI="https://github.com/iamkroot/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/cleo-0.7.6[${PYTHON_USEDEP}]
	>=dev-python/clikit-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/pylev-1.3[${PYTHON_USEDEP}]
	>=dev-python/pastel-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/jeepney-0.6[${PYTHON_USEDEP}]
	>=dev-python/requests-2.22.0[${PYTHON_USEDEP}]
	>=dev-python/guessit-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/confuse-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/appdirs-1.4.3[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	dev-python/idna[${PYTHON_USEDEP}]
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/babelfish[${PYTHON_USEDEP}]
	dev-python/rebulk[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/urlmatch[${PYTHON_USEDEP}]
	dev-python/crashtest[${PYTHON_USEDEP}]
"

distutils_enable_tests unittest

python_test(){
	eunittest tests/
}

pkg_postinst() {
	optfeature "start at boot support (see the trakts autostart command)" sys-apps/systemd
}
