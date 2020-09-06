# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )

DOCBUILDER="mkdocs"
DOCDEPEND="dev-python/mkdocs-material"
AUTODOC=1

inherit distutils-r1 docs

DESCRIPTION="A next generation HTTP client for Python"
HOMEPAGE="
	https://www.python-httpx.org
	https://github.com/encode/httpx
	https://pypi.org/project/httpx
"
SRC_URI="https://github.com/encode/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND="dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/hstspreload[${PYTHON_USEDEP}]
	~dev-python/httpcore-0.10.1[${PYTHON_USEDEP}]
	dev-python/hyper-h2[${PYTHON_USEDEP}]
	dev-python/h11[${PYTHON_USEDEP}]
	dev-python/idna[${PYTHON_USEDEP}]
	dev-python/rfc3986[${PYTHON_USEDEP}]
	dev-python/sniffio[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
"

DEPEND="test? (
	dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/brotlipy[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/isort[${PYTHON_USEDEP}]
	dev-python/mypy[${PYTHON_USEDEP}]
	dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	dev-python/trio[${PYTHON_USEDEP}]
	dev-python/trustme[${PYTHON_USEDEP}]
	dev-python/uvicorn[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest

python_prepare_all() {
	# do not depend on pytest-cov
	sed -i -e '/addopts/d' setup.cfg || die

	distutils-r1_python_prepare_all
}
