# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="glue between async and thread worlds"
HOMEPAGE="
	https://github.com/mosquito/aiothreads
	https://pypi.org/project/aiothreads/
"
SRC_URI="https://github.com/mosquito/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

EPYTEST_PLUGINS=(
	async-timeout
	pytest-asyncio
)
distutils_enable_tests pytest

src_prepare() {
	sed -i "s/^version = \"1.0.0\"/version = \"${PV}\"/" pyproject.toml || die

	distutils-r1_src_prepare
}

python_test() {
	epytest -o addopts=
}
