# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

DISTUTILS_USE_PEP517=poetry

inherit distutils-r1

DESCRIPTION="Collect your thoughts and notes without leaving the command line"
HOMEPAGE="https://jrnl.sh"
SRC_URI="https://github.com/jrnl-org/jrnl/archive/refs/tags/v${PV}.tar.gz  -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

PATCHES="
	${FILESDIR}/tomli.patch
"
#	${FILESDIR}/test_fixes.patch


DEPEND="
	dev-python/rich
	dev-python/colorama
	dev-python/cryptography
	dev-python/keyring
	dev-python/parsedatetime
	dev-python/python-dateutil
	dev-python/pyxdg
	dev-python/ruamel-yaml
	dev-python/tzlocal
	test? (
		<=dev-python/pytest-8.1
		>dev-python/pytest-bdd-6.0
		>dev-python/pytest-xdist-2.5.0
		dev-python/tomli
		)
"

RDEPEND="${DEPEND}"
distutils_enable_tests pytest
