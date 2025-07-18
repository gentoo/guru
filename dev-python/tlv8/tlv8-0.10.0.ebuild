# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1

DESCRIPTION="Type-Length-Value8 (TLV8) for python"
HOMEPAGE="https://github.com/jlusiardi/tlv8_python https://pypi.org/project/tlv8/"
SRC_URI="https://github.com/jlusiardi/tlv8_python/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}_python-${PV}"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DOCS=(
	CHANGES.md
	README.md
)

distutils_enable_tests pytest
