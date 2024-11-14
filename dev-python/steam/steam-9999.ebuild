# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )

inherit git-r3 distutils-r1

EGIT_REPO_URI="https://github.com/ValvePython/steam.git"
DESCRIPTION="Python package for interacting with Steam"
HOMEPAGE="https://github.com/ValvePython/steam"

DEPEND="dev-python/six
	dev-python/pycryptodome
	dev-python/requests
	dev-python/urllib3
	dev-python/vdf
	dev-python/protobuf
	dev-python/cachetools
"
LICENSE="GPL-3"
SLOT="0"

src_compile() {
	distutils-r1_src_compile
}

src_install() {
	distutils-r1_src_install
}
