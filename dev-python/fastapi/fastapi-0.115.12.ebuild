# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm-backend
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="FastAPI framework, high performance, easy to learn, ready for production"
HOMEPAGE="
	https://fastapi.tiangolo.com/
	https://pypi.org/project/fastapi/
	https://github.com/fastapi/fastapi
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	<dev-python/pydantic-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-1.7.4[${PYTHON_USEDEP}]
	<dev-python/starlette-0.47.0[${PYTHON_USEDEP}]
	>=dev-python/starlette-0.40.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.8.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/aiosqlite[${PYTHON_USEDEP}]
		>=dev-python/anyio-3.2.1[${PYTHON_USEDEP}]
		dev-python/dirty-equals[${PYTHON_USEDEP}]
		dev-python/email-validator[${PYTHON_USEDEP}]
		>=dev-python/flask-1.1.2[${PYTHON_USEDEP}]
		dev-python/inline-snapshot[${PYTHON_USEDEP}]
		>=dev-python/jinja2-3.1.5[${PYTHON_USEDEP}]
		dev-python/orjson[${PYTHON_USEDEP}]
		<dev-python/passlib-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/passlib-1.7.2[${PYTHON_USEDEP}]
		dev-python/pydantic-settings[${PYTHON_USEDEP}]
		dev-python/pyjwt[${PYTHON_USEDEP}]
		>=dev-python/python-multipart-0.0.18[${PYTHON_USEDEP}]
		<dev-python/pyyaml-7.0.0[${PYTHON_USEDEP}]
		>=dev-python/pyyaml-5.3.1[${PYTHON_USEDEP}]
		dev-python/sqlmodel[${PYTHON_USEDEP}]
		dev-python/trio[${PYTHON_USEDEP}]
		dev-python/ujson[${PYTHON_USEDEP}]
	)
"
# brottli and zstd due to starlette based tests expecting it

PATCHES=(
	"${FILESDIR}"/fastaapi-0.115.6-httpx-0.28-test-fix.patch
)

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# Depends on coverage
	"tests/test_fastapi_cli.py::test_fastapi_cli"
	# Test result affected by unrelated packages such as brottli and zstd
	# https://github.com/fastapi/fastapi/blob/7c6f2f8fde68f488163376c9e92a59d46c491298/tests/test_tutorial/test_header_param_models/test_tutorial001.py#L77
	"tests/test_tutorial/test_header_param_models/test_tutorial001.py::test_header_param_model_invalid"
	# https://gitweb.gentoo.org/repo/gentoo.git/commit/?id=6afa196ca0cb1604875847b1b84fa64896a06f6e
	"tests/test_multipart_installation.py::test_incorrect_multipart_installed_form"
	"tests/test_multipart_installation.py::test_incorrect_multipart_installed_file_upload"
	"tests/test_multipart_installation.py::test_incorrect_multipart_installed_file_bytes"
	"tests/test_multipart_installation.py::test_incorrect_multipart_installed_multi_form"
	"tests/test_multipart_installation.py::test_incorrect_multipart_installed_form_file"
	"tests/test_multipart_installation.py::test_no_multipart_installed"
	"tests/test_multipart_installation.py::test_no_multipart_installed_file"
	"tests/test_multipart_installation.py::test_no_multipart_installed_file_bytes"
	"tests/test_multipart_installation.py::test_no_multipart_installed_multi_form"
	"tests/test_multipart_installation.py::test_no_multipart_installed_form_file"
	"tests/test_multipart_installation.py::test_old_multipart_installed"
)

python_prepare_all() {
	# Dont install fastapi executable as fastapi-cli is supposed to handle it
	sed -i -e '/\[project.scripts\]/,/^$/d' pyproject.toml || die

	distutils-r1_python_prepare_all
}

pkg_postinst() {
	optfeature "commandline interface" dev-python/fastapi-cli
	optfeature "test client" dev-python/httpx
	optfeature "templates" dev-python/jinja2
	optfeature "forms and file uploads" dev-python/python-multipart
	optfeature "validate emails" dev-python/email-validator
	optfeature "uvicorn with uvloop" dev-python/uvicorn
	optfeature_header "Alternative JSON responses"
	optfeature "ORJSONResponse" dev-python/orjson
	optfeature "UJSONResponse" dev-python/ujson
}
