# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="Bmaptool is a tool for creating and copyng files using block maps"
HOMEPAGE="https://github.com/intel/bmap-tools"

SRC_URI="https://github.com/intel/bmap-tools/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
S="${WORKDIR}/bmap-tools-3.6"
RDEPEND="dev-python/six"

python_install_all() {
	distutils-r1_python_install_all
}
