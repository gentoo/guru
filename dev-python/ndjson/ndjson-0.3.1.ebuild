# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_14 )

inherit distutils-r1 pypi

DESCRIPTION="Ndjson with the same interface as the builtin json module"
HOMEPAGE="https://github.com/rhgrant10/ndjson"
SRC_URI="https://github.com/rhgrant10/ndjson/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest
