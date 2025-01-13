# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )

inherit distutils-r1

DESCRIPTION="Python package for interacting with Steam"
HOMEPAGE="
	https://github.com/solsticegamestudios/steam/
	https://pypi.org/project/steam/
"
SRC_URI="
	https://github.com/solsticegamestudios/steam/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/cachetools-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/pycryptodome-3.7.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.9.1[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/vdf-4.0[${PYTHON_USEDEP}]

	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/protobuf[${PYTHON_USEDEP}]
	dev-python/wsproto[${PYTHON_USEDEP}]
"

pkg_postinst() {
	if [[ ! ${REPLACING_VERSIONS} ]]; then
		ewarn "If you intend to use this library for anything else than"
		ewarn "ProtonUp-Qt you most likely need additional ebuilds for"
		ewarn "gevent and gevent-eventemitter. These are currently not"
		ewarn "part of the GURU repository."
		ewarn
		ewarn "Project references:"
		ewarn " - http://www.gevent.org/"
		ewarn " - https://github.com/rossengeorgiev/gevent-eventemitter"
	fi
}
