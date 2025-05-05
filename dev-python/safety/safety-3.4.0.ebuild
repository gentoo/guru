# Copyright 2025
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_11 python3_12 )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

DESCRIPTION="Scan dependencies for known vulnerabilities and licenses."

HOMEPAGE="https://safetycli.com"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-python/authlib-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/click-8.0.2[${PYTHON_USEDEP}]
	>=dev-python/dparse-0.6.4[${PYTHON_USEDEP}]
	>=dev-python/filelock-3.16.1[${PYTHON_USEDEP}]
	>=dev-python/jinja2-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/marshmallow-3.15.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-21.0[${PYTHON_USEDEP}]
	>=dev-python/psutil-6.1.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.6.0[${PYTHON_USEDEP}]
	<dev-python/pydantic-2.10.7[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/httpx[${PYTHON_USEDEP}]
	dev-python/tenacity[${PYTHON_USEDEP}]
	~dev-python/safety-schemas-0.0.14[${PYTHON_USEDEP}]
	>=dev-python/setuptools-65.5.1[${PYTHON_USEDEP}]
	>=dev-python/typer-0.12.1[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.7.1[${PYTHON_USEDEP}]
	>=dev-python/nltk-3.9[${PYTHON_USEDEP}]
	dev-python/tomlkit[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"
