# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1 pypi

DESCRIPTION="A set of UFO based objects for use in font editing applications"
HOMEPAGE="https://github.com/robotools/defcon"
SRC_URI="$(pypi_sdist_url ${PN} ${PV} .zip)"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/fonttools-4.34.4[${PYTHON_USEDEP}]"
BDEPEND="
	app-arch/unzip
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		dev-python/fs[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_configure() {
	export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}
	distutils-r1_src_configure
}
