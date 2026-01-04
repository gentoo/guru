# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Typing stubs for requests"
HOMEPAGE="
	https://pypi.org/project/types-requests/
	https://github.com/python/typeshed/tree/master/stubs/requests
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND=">=dev-python/urllib3-2"
