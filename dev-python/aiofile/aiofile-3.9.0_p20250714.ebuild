# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Asynchronous file operations"
HOMEPAGE="
	https://github.com/mosquito/aiofile
	https://pypi.org/project/aiofile/
"
# We depend on some unreleased fixes
MY_COMMIT="ba7cbede109d7972064ad39433648051f659c0f1" # _p20250714
SRC_URI="https://github.com/mosquito/${PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-python/caio-0.9.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( aiomisc-pytest )
distutils_enable_tests pytest
