# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="Fypp - Python powered Fortran preprocessor"
HOMEPAGE="https://github.com/aradi/fypp"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RESTRICT="!test? ( test )"

python_test() {
	# pass python version as arg
	test/runtests.sh ${EPYTHON} || die
}
