# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=standalone
DISTUTILS_EXT=1
inherit distutils-r1

MY_PN="cadquery_ocp_novtk"
MY_PV="${PV/_p/.post}"

DESCRIPTION="Python wrapper for OCCT (no VTK) - prebuilt binary package"
HOMEPAGE="https://github.com/CadQuery/OCP https://pypi.org/project/cadquery-ocp-novtk/"

SRC_URI="
	python_targets_python3_11? (
		https://files.pythonhosted.org/packages/a2/4e/36707561b5c80a671ea6c99f156104debb8dcc2fa8aeb24ebe3bd023cee7/${MY_PN}-${MY_PV}-cp311-cp311-manylinux_2_31_x86_64.whl
			-> ${MY_PN}-${MY_PV}-cp311-cp311-linux_x86_64.whl
	)
	python_targets_python3_12? (
		https://files.pythonhosted.org/packages/cd/6a/c973f2b530651193dec6f5c14b50226abddc6d2a065b57ac866069f208ff/${MY_PN}-${MY_PV}-cp312-cp312-manylinux_2_31_x86_64.whl
			-> ${MY_PN}-${MY_PV}-cp312-cp312-linux_x86_64.whl
	)
	python_targets_python3_13? (
		https://files.pythonhosted.org/packages/74/08/1de4750b267a500ca900b3c7ab754790afe7f9dbb8a301258739b72c69e2/${MY_PN}-${MY_PV}-cp313-cp313-manylinux_2_31_x86_64.whl
			-> ${MY_PN}-${MY_PV}-cp313-cp313-linux_x86_64.whl
	)
"

S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# test: no test suite included in binary wheel
RESTRICT="bindist mirror strip test"

QA_PREBUILT="*"

python_compile() {
	local pyver="${EPYTHON/python/}"
	pyver="${pyver/./}"
	distutils_wheel_install "${BUILD_DIR}/install" \
		"${DISTDIR}/${MY_PN}-${MY_PV}-cp${pyver}-cp${pyver}-linux_x86_64.whl"
}
