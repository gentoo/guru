# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Library for accessing ar files"
HOMEPAGE="https://github.com/viraptor/arpy"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="test"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

distutils_enable_tests unittest

python_test() {
	eunittest -v test
}
