# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1

DESCRIPTION="A script to run docker-compose.yml using Podman"
HOMEPAGE="https://github.com/containers/podman-compose"
SRC_URI="https://github.com/containers/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	|| (
		( app-containers/netavark app-containers/aardvark-dns )
		app-containers/dnsname-cni-plugin
	)
	app-containers/podman
	dev-python/pyaml[${PYTHON_USEDEP}]
	dev-python/python-dotenv[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

distutils_enable_tests pytest

python_test() {
	epytest pytests
}
