# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="Digitalocean API access library"
HOMEPAGE="https://github.com/koalalorenzo/python-digitalocean"
SRC_URI="https://github.com/koalalorenzo/python-digitalocean/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/python-digitalocean-${PV}

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/jsonpickle[${PYTHON_USEDEP}]
"
