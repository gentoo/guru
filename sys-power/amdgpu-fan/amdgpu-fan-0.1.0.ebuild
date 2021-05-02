# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1 systemd

DESCRIPTION="Fan controller for AMD graphics cards running the amdgpu driver on Linux"
HOMEPAGE="https://github.com/zzkW35/amdgpu-fan"
SRC_URI="https://github.com/zzkW35/amdgpu-fan/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	${PYTHON_DEPS}
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
"
DEPEND="${PYTHON_DEPS}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
DOCS=( README.md )

python_install_all() {
	distutils-r1_python_install_all
	systemd_dounit amdgpu-fan.service
}
