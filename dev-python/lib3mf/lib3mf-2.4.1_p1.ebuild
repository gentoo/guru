# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=standalone
DISTUTILS_EXT=1
inherit distutils-r1

MY_PV="${PV/_p/.post}"

DESCRIPTION="Python bindings for the lib3mf 3D Manufacturing Format library"
HOMEPAGE="https://github.com/3MFConsortium/lib3mf https://pypi.org/project/lib3mf/"

SRC_URI="
	https://files.pythonhosted.org/packages/4d/fc/fe9c31852c02b263763323a3afeaab0538106887b9ed6de85b72043417a5/${PN}-${MY_PV}-py3-none-manylinux2014_x86_64.whl
		-> ${PN}-${MY_PV}-py3-none-linux_x86_64.whl
"

S="${WORKDIR}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

# test: no Python test suite included in binary wheel (upstream tests are C++ only)
RESTRICT="bindist mirror strip test"

QA_PREBUILT="*"

python_compile() {
	distutils_wheel_install "${BUILD_DIR}/install" \
		"${DISTDIR}/${PN}-${MY_PV}-py3-none-linux_x86_64.whl"
}
