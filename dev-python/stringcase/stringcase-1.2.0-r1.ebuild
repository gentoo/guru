# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..11} )

DISTUTILS_USE_SETUPTOOLS=no

inherit distutils-r1 pypi

DESCRIPTION="Convert string cases between camel case, pascal case, snake case etc."
HOMEPAGE="https://github.com/okunishinishi/python-stringcase"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~x86"
