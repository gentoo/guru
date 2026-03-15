# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_VERIFY_REPO=https://github.com/discord-userdoccers/discord-protos
PYTHON_COMPAT=( python3_{12..14} )

inherit pypi distutils-r1

DESCRIPTION="Reverse-engineering Discord's protobufs"
HOMEPAGE="
	https://pypi.org/project/discord-protos/
	https://github.com/discord-userdoccers/discord-protos
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/protobuf[${PYTHON_USEDEP}]
"
