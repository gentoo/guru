# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
PYTHON_REQ_USE="tk"
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_SETUPTOOLS=rdepend

MY_PN="jellyfin-mpv-shim"
MY_P="${MY_PN}-${PV}"

inherit distutils-r1

DESCRIPTION="MPV-based desktop and cast client for Jellyfin"
HOMEPAGE="https://github.com/jellyfin/jellyfin-desktop"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="LGPL-3+ MIT Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	$(python_gen_cond_dep '
		dev-python/python-mpv[${PYTHON_USEDEP}]
		>=dev-python/jellyfin-apiclient-python-1.7.2[${PYTHON_USEDEP}]
		>=dev-python/python-mpv-jsonipc-1.1.9[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
	')
"
RDEPEND="
	${DEPEND}
	dev-libs/libappindicator:3=
	$(python_gen_cond_dep '
		dev-python/flask[${PYTHON_USEDEP}]
		dev-python/jinja[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/pystray[${PYTHON_USEDEP}]
		>=dev-python/pywebview-3.3.1[${PYTHON_USEDEP}]
		dev-python/werkzeug[${PYTHON_USEDEP}]
	')
"

S="${WORKDIR}/${MY_P}"
