# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1

DESCRIPTION="Python library for OpenDocument format (ODF)"
HOMEPAGE="https://github.com/jdum/odfdo"
SRC_URI="https://github.com/jdum/odfdo/archive/refs/tags/v${PV}.tar.gz -> odfdo-${PV}.tar.gz"
S="${WORKDIR}/odfdo-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/poetry-core-1.9.1
"
