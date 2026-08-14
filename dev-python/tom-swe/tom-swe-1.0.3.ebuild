# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

MY_PN="ToM-SWE"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Theory of Mind modeling for Software Engineering assistants"
HOMEPAGE="
	https://github.com/OpenHands/ToM-SWE
	https://pypi.org/project/tom-swe/
"
SRC_URI="https://github.com/OpenHands/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64" # ~arm64: litellm

# pyyaml via litellm[proxy]
RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/jinja2-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/json-repair-0.1.0[${PYTHON_USEDEP}]
		>=dev-python/pydantic-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/python-dotenv-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/pyyaml-6.0.3[${PYTHON_USEDEP}]
		>=dev-python/tiktoken-0.8.0[${PYTHON_USEDEP}]
		>=dev-python/tqdm-4.65.0[${PYTHON_USEDEP}]
	')
	>=dev-python/litellm-1.0.0[${PYTHON_SINGLE_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
