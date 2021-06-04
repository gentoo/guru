# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="A more Pythonic version of doxypy, a Doxygen filter for Python"
HOMEPAGE="
	https://github.com/eigenein/protobuf
	https://pypi.org/project/pure-protobuf/
"
SRC_URI="https://github.com/eigenein/protobuf/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/protobuf-${PV}"

distutils_enable_tests pytest

PATCHES="${FILESDIR}/${PN}-do-not-install-tests.patch"
