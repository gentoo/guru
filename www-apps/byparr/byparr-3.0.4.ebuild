# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=no
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 systemd

DESCRIPTION="Proxy server to bypass captchas"
HOMEPAGE="https://github.com/ThePhaseless/Byparr"
SRC_URI="https://github.com/ThePhaseless/Byparr/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/Byparr-${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	acct-group/byparr
	acct-user/byparr

	$(python_gen_cond_dep '
		dev-python/fastapi[${PYTHON_USEDEP}]
		dev-python/invisible-playwright[${PYTHON_USEDEP}]
		dev-python/playwright-captcha[${PYTHON_USEDEP}]
		dev-python/playwright[${PYTHON_USEDEP}]
		dev-python/pydantic-settings[${PYTHON_USEDEP}]
		dev-python/pydantic[${PYTHON_USEDEP}]
		dev-python/trafilatura[${PYTHON_USEDEP}]
		dev-python/uvicorn[${PYTHON_USEDEP}]
	')
"
BDEPEND="
	test? (
		$(python_gen_cond_dep '
			dev-python/httpx2[${PYTHON_USEDEP}]
			dev-python/starlette[${PYTHON_USEDEP}]
		')
	)
"

EPYTEST_DESELECT=(
	"tests/main_test.py::test_bypass"
	"tests/main_test.py::test_health_check"
	"tests/main_test.py::test_json_api"
	"tests/main_test.py::test_pdf_handling"
	"tests/owui_test.py::test_networkidle_timeout_still_extracts_content"
	"tests/owui_test.py::test_owui_load_accepts_valid_key"
	"tests/owui_test.py::test_owui_load_basic"
	"tests/owui_test.py::test_owui_load_invalid_url_graceful"
	"tests/owui_test.py::test_owui_load_multiple_urls"
)

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

src_prepare() {
	# Let's turn `src` into a proper Python module
	find . \
		-type f -name "*.py" \
		-exec sed 's/from src/from byparr/g' -i {} + || die
	sed 's/src\./byparr\./g' -i tests/owui_test.py || die
	mv src byparr || die

	sed -e '1i #!/usr/bin/env python' -i main.py || die

	distutils-r1_src_prepare
}

python_install() {
	python_domodule "${PN}"
	python_newscript main.py "${PN}"

	systemd_dounit "${FILESDIR}/byparr.service"
}
