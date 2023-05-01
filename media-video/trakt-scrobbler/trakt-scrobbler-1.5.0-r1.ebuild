# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_10 )

inherit distutils-r1 optfeature

DESCRIPTION="Scrobbler for trakt.tv that supports VLC, Plex, MPC-HC, and MPV"
HOMEPAGE="https://github.com/iamkroot/trakt-scrobbler"
SRC_URI="https://github.com/iamkroot/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/requests-2.25.1[${PYTHON_USEDEP}]
	<dev-python/requests-3[${PYTHON_USEDEP}]
	>=dev-python/urllib3-1.26.0[${PYTHON_USEDEP}]
	<dev-python/urllib3-2[${PYTHON_USEDEP}]
	>=dev-python/guessit-3.3.1[${PYTHON_USEDEP}]
	<dev-python/guessit-4[${PYTHON_USEDEP}]
	>=dev-python/appdirs-1.4.4[${PYTHON_USEDEP}]
	<dev-python/appdirs-2[${PYTHON_USEDEP}]
	>=dev-python/cleo-0.8.1[${PYTHON_USEDEP}]
	<dev-python/cleo-0.9[${PYTHON_USEDEP}]
	>=dev-python/confuse-2.0[${PYTHON_USEDEP}]
	<dev-python/confuse-3[${PYTHON_USEDEP}]
	>=dev-python/urlmatch-1.0.1[${PYTHON_USEDEP}]
	<dev-python/urlmatch-2[${PYTHON_USEDEP}]
	dev-python/clikit[${PYTHON_USEDEP}]
	dev-python/crashtest[${PYTHON_USEDEP}]
"

distutils_enable_tests unittest

python_test(){
	eunittest tests/
}

python_install() {
	distutils-r1_python_install

	insinto "/usr/share/zsh/site-functions"
	newins "${S}/completions/trakts.zsh" "_trakts"
}

pkg_postinst() {
	optfeature "start at boot support (see the trakts autostart command)" sys-apps/systemd
}
