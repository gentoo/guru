# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

MY_PN="PyAV"
MY_P=${MY_PN}-${PV}

DESCRIPTION="﻿﻿Pythonic bindings for FFmpeg's libraries"
HOMEPAGE="
	https://pyav.basswood-io.com/docs/stable/
	https://pypi.org/project/av/
	https://github.com/PyAV-Org/PyAV/
"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/PyAV-Org/PyAV.git"
else
	# pypi misses documentation
	SRC_URI="https://github.com/PyAV-Org/PyAV/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
	KEYWORDS="~amd64"
	S=${WORKDIR}/${MY_P}
fi

LICENSE="BSD"
SLOT="0"

IUSE="examples"

BDEPEND="
	virtual/pkgconfig
	>=dev-python/cython-3.1.0[${PYTHON_USEDEP}]
	test? (
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
	)
"
DEPEND="media-video/ffmpeg:="
RDEPEND="
	media-video/ffmpeg:=
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
"

DOCS=( README.md {AUTHORS,CHANGELOG}.rst )

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-copybutton

src_prepare() {
	default

	# package directory must be deleted due to C ext.
	# use PV instead of reading from pkg. dir.
	sed -i \
	-e 's|about = {}|about = {"__version__": "'"${PV}"'"}|' \
	-e '/with open/,+2d' \
	docs/conf.py || die
}

python_compile_all() {
	rm -rf av || die

	sphinx_compile_all
}

python_install_all() {
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
	distutils-r1_python_install_all
}

python_test() {
	rm -rf av || die

	epytest
}
