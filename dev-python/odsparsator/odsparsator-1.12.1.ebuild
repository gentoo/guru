# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1

DESCRIPTION="Generate a JSON file from an OpenDocument Format .ods file."
HOMEPAGE="https://github.com/jdum/odsparsator"
SRC_URI="https://github.com/jdum/odsparsator/archive/refs/tags/v${PV}.tar.gz -> odsparsator-${PV}.tar.gz"
S="${WORKDIR}/odsparsator-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/poetry-core-1.9.1
"
