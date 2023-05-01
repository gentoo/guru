# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

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

distutils_enable_tests unittest

src_prepare() {
	sed -e "s|PROJECTVERSION|${PV}|g" -i setup.py || die
	default
}

python_install_all() {
	distutils-r1_python_install_all
	systemd_dounit amdgpu-fan.service
}

python_test() {
	"${EPYTHON}" -m unittest discover tests || die
}
