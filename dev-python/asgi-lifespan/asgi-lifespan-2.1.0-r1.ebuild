# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Programmatic startup/shutdown of ASGI apps"
HOMEPAGE="
	https://github.com/florimondmanca/asgi-lifespan/
	https://pypi.org/project/asgi-lifespan/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/sniffio[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		dev-python/starlette[${PYTHON_USEDEP}]
		dev-python/trio[${PYTHON_USEDEP}]
		dev-python/httpx[${PYTHON_USEDEP}]
	)
"

EPYTEST_DESELECT=(
	# https://github.com/florimondmanca/asgi-lifespan/issues/63
	tests/test_manager.py::test_lifespan_manager
	tests/test_manager.py::test_lifespan_not_supported
	tests/test_manager.py::test_lifespan_timeout
	# https://github.com/florimondmanca/asgi-lifespan/issues/65
	tests/test_manager.py::test_lifespan_state_async_cm
)
EPYTEST_PLUGINS=( pytest-asyncio pytest-trio )
distutils_enable_tests pytest

python_test() {
	epytest -o addopts=
}
