# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Mutes your microphone while you are typing"
HOMEPAGE="https://kryogenix.org/code/hushboard/"
LICENSE="MIT"
SLOT="0"

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/stuartlangridge/hushboard.git"
	inherit git-r3
else
	HUSHBOARD_COMMIT_ID="5d62c2aacb876f7178d8002a22e44128ac312c98"
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
