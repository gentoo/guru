# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 #pypi

DESCRIPTION="A library for creating GraphQL APIs"
HOMEPAGE="
	https://strawberry.rocks/
	https://github.com/strawberry-graphql/strawberry/
	https://pypi.org/project/strawberry-graphql/
"
# no tests in sdist
SRC_URI="
	https://github.com/strawberry-graphql/strawberry/archive/refs/tags/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"
S="${WORKDIR}/strawberry-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/cross-web-0.4.0[${PYTHON_USEDEP}]
	<dev-python/graphql-core-3.4.0[${PYTHON_USEDEP}]
	>=dev-python/graphql-core-3.2.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-23[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.7[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.5.0[${PYTHON_USEDEP}]
"

# dev
# integrations
BDEPEND="
	test? (
		dev-python/asgiref[${PYTHON_USEDEP}]
		dev-python/email-validator[${PYTHON_USEDEP}]
		dev-python/freezegun[${PYTHON_USEDEP}]
		dev-python/libcst[${PYTHON_USEDEP}]
		dev-python/markupsafe[${PYTHON_USEDEP}]
		dev-python/opentelemetry-api[${PYTHON_USEDEP}]
		dev-python/pygments[${PYTHON_USEDEP}]
		dev-python/pyinstrument[${PYTHON_USEDEP}]
		dev-python/python-multipart[${PYTHON_USEDEP}]
		dev-python/rich[${PYTHON_USEDEP}]
		dev-python/typer[${PYTHON_USEDEP}]
		dev-python/urllib3[${PYTHON_USEDEP}]
		dev-python/inline-snapshot[${PYTHON_USEDEP}]

		dev-python/aiohttp[${PYTHON_USEDEP}]
		dev-python/chalice[${PYTHON_USEDEP}]
		dev-python/channels[${PYTHON_USEDEP}]
		dev-python/django[${PYTHON_USEDEP}]
		dev-python/fastapi[${PYTHON_USEDEP}]
		dev-python/flask[${PYTHON_USEDEP}]
		dev-python/quart[${PYTHON_USEDEP}]
		dev-python/pydantic[${PYTHON_USEDEP}]
		dev-python/starlette[${PYTHON_USEDEP}]
		dev-python/litestar[${PYTHON_USEDEP}]
		dev-python/uvicorn[${PYTHON_USEDEP}]
	)
"

EPYTEST_IGNORE=(
	"tests/benchmarks/"
	# avoid daphne which requires autobahn
	"tests/channels/test_layers.py"
	"tests/channels/test_testing.py"
	"tests/http/clients/channels.py"
	# FIXME:
	"tests/http/test_graphql_ide.py"
)
EPYTEST_DESELECT=(
	# TODO: sanic
	"tests/sanic/test_file_upload.py::test_file_cast"
	"tests/sanic/test_file_upload.py::test_endpoint"
	# test stdlib?
	"tests/schema/test_lazy/test_lazy_generic.py::test_lazy_types_loaded_from_same_module[script]"
	# FIXME
	"tests/django/test_dataloaders.py::test_fetch_data_from_db"
)
EPYTEST_PLUGINS=( pytest-aiohttp pytest-asyncio pytest-django pytest-mock pytest-snapshot )
distutils_enable_tests pytest

PATCHES=(
	"${FILESDIR}"/strawberry-0.288.3-no-emoji-test.patch
)

python_test() {
	local -x DJANGO_SETTINGS_MODULE="tests.django.django_settings"

	# avoid superfluous pytest-emoji dependency
	epytest -o addopts=
}
