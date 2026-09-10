# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_14 )

inherit distutils-r1

DESCRIPTION="AI-powered git commit message generator using LLMs via OpenAI-compat APIs"
HOMEPAGE="https://github.com/can1357/llm-git"
SRC_URI="https://github.com/can1357/${PN}/archive/v${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/httpx2-2.4.0[${PYTHON_USEDEP}]
	dev-python/blake3[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-vcs/git
"

BDEPEND="test? ( dev-vcs/git )"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

src_prepare() {
	sed -i \
		-e 's/^import httpx$/import httpx2 as httpx/' \
		lgit/{api,cli,tokens}.py tests/test_pricing.py || die
	sed -i -e 's/"httpx"/"httpx2"/' pyproject.toml || die
	distutils-r1_src_prepare
}

python_test() {
	git init -q || die
	epytest
}
