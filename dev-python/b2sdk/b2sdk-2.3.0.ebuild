# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_PEP517="pdm-backend"
PYTHON_COMPAT=( python3_10 python3_11 python3_12 )
inherit distutils-r1

DESCRIPTION="The client library for BackBlaze's B2 product"
HOMEPAGE="https://github.com/Backblaze/b2-sdk-python"
SRC_URI="https://github.com/Backblaze/b2-sdk-python/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/b2-sdk-python-${PV}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

export PDM_BUILD_SCM_VERSION=${PV}

RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/logfury-1.0.1[${PYTHON_USEDEP}]
		>=dev-python/requests-2.9.1[${PYTHON_USEDEP}]
		>=dev-python/typing-extensions-4.7.1[${PYTHON_USEDEP}]
	')
"

distutils_enable_tests pytest

# tqdm dependency is temporary, see
# https://github.com/Backblaze/b2-sdk-python/issues/489
BDEPEND+=" test? (
	$(python_gen_cond_dep '
		>=dev-python/pytest-mock-3.6.1[${PYTHON_USEDEP}]
		>=dev-python/pytest-lazy-fixture-0.6.3[${PYTHON_USEDEP}]
		>=dev-python/tqdm-4.66.2[${PYTHON_USEDEP}]
	')
)"

# These tests seem to require some b2 authentication (they're integration tests
# so this is not unreasonable)
EPYTEST_DESELECT=(
	# These integration tests require an actual connection to backblaze, which
	# can't typically work in the sandbox
	test/integration
)
