# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="Mutes your microphone while you are typing"
HOMEPAGE="https://kryogenix.org/code/hushboard/"
LICENSE="MIT"
SLOT="0"

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/stuartlangridge/hushboard.git"
	inherit git-r3
else
	HUSHBOARD_COMMIT_ID="c16611c539be111891116a737b02c5fb359ad1fc"
	SRC_URI="https://github.com/stuartlangridge/hushboard/archive/${HUSHBOARD_COMMIT_ID}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${HUSHBOARD_COMMIT_ID}"
	KEYWORDS="~amd64"
fi

RDEPEND="
	dev-libs/libappindicator
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/python-xlib[${PYTHON_USEDEP}]
"
