# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1
distutils_enable_tests pytest

DESCRIPTION="Terminal-based interface to manage virtual machines using libvirt"
HOMEPAGE="https://aginies.github.io/virtui-manager/"
SRC_URI="https://github.com/aginies/virtui-manager/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/virtui-manager-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/libvirt-python[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/textual[${PYTHON_USEDEP}]
	sys-libs/libosinfo[introspection]
	app-emulation/libvirt
	app-emulation/qemu
	app-emulation/virt-manager
	dev-python/netifaces
"
BDEPEND="
	${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	test? ( dev-python/pytest-cov[${PYTHON_USEDEP}] )
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )
"

src_prepare()
{
	default
	distutils-r1_src_prepare
}

python_test()
{
	epytest -o "addopts="
}
