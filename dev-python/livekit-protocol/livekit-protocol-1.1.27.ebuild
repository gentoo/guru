# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1 pypi

DESCRIPTION="Python protocol stubs for LiveKit"
HOMEPAGE="
	https://github.com/livekit/python-sdks/
	https://pypi.org/project/livekit-protocol/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/protobuf-5[${PYTHON_USEDEP}]
	>=dev-python/types-protobuf-5[${PYTHON_USEDEP}]"
