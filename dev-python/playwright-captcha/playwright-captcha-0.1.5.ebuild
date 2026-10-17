# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# No tags in the repository, but there are tags on PyPI
EGIT_COMMIT="b316e4f4989d7b2b9fdd9ee4826cf4aeb9cb1151"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="Automating captcha solving for Playwright"
HOMEPAGE="
	https://github.com/techinz/playwright-captcha
	https://pypi.org/project/playwright-captcha/
"
SRC_URI="https://github.com/techinz/playwright-captcha/archive/${EGIT_COMMIT}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

# License file is different from the license field in `pyproject.toml`
LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/2captcha[${PYTHON_USEDEP}]
	dev-python/playwright[${PYTHON_USEDEP}]
	dev-python/python-dotenv[${PYTHON_USEDEP}]
"

EPYTEST_DESELECT=(
	"tests/integration/test_cloudflare_click.py::TestCloudflareClickSolvers::test_click_interstitial_solver"
	"tests/integration/test_cloudflare_click.py::TestCloudflareClickSolvers::test_click_turnstile_solver"
)

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest
