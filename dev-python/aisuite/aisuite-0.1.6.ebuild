# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1

DESCRIPTION="Simple, unified interface to multiple Generative AI providers"
HOMEPAGE="https://github.com/andrewyng/aisuite/"
SRC_URI="https://github.com/andrewyng/aisuite/releases/download/v${PV}/aisuite-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
