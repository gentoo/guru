# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( pypy3 python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Read/Write project management files (MPP, MSPDI, MPX, PMXML, etc)"
HOMEPAGE="
	https://pypi.org/project/mpxj/
	https://github.com/joniles/mpxj/
"
SRC_URI="$(pypi_wheel_url)"
S="${WORKDIR}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/jpype-1.5.0
"

src_unpack() {
	if [[ ${PKGBUMPING} == ${PVR} ]]; then
		unzip "${DISTDIR}/${A}" || die
	fi
}

python_compile() {
	distutils_wheel_install "${BUILD_DIR}/install" \
		"${DISTDIR}/${P}-py3-none-any.whl"

	# Clean up spurious folder
	rm -fr "${BUILD_DIR}/install"/usr/lib/python*/site-packages/legal || die
}
