# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_6 )

inherit distutils-r1 eutils

DESCRIPTION="The little ASGI framework that shines"
HOMEPAGE="
	https://www.starlette.io/
	https://github.com/encode/starlette
"
SRC_URI="https://github.com/encode/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="doc"

# ModuleNotFoundError: No module named 'graphql.pyutils.compat'
# We need newer graphql-core
RESTRICT="test"

BDEPEND="doc? (
	dev-python/mkdocs
	dev-python/mkdocs-material
	dev-python/mkautodoc )"

DEPEND="test? (
	dev-python/aiofiles[${PYTHON_USEDEP}]
	dev-python/black[${PYTHON_USEDEP}]
	dev-python/databases[${PYTHON_USEDEP}]
	dev-python/isort[${PYTHON_USEDEP}]
	dev-python/itsdangerous[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/mypy[${PYTHON_USEDEP}]
	dev-python/python-multipart[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/sse-starlette[${PYTHON_USEDEP}]
	dev-python/ujson[${PYTHON_USEDEP}]
	dev-python/graphene[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# do not install LICENSE to /usr/
	sed -i -e '/data_files/d' setup.py || die

	distutils-r1_python_prepare_all
}

python_compile_all() {
	default
	if use doc; then
		mkdocs build || die "failed to make docs"
		HTML_DOCS="site"
	fi
}

pkg_postinst() {
	optfeature "Required if you want to use FileResponse or StaticFiles" dev-python/aiofiles
	optfeature "Required if you want to use Jinja2Templates" dev-python/jinja
	optfeature "Required if you want to support form parsing, with request.form()" dev-python/python-multipart
	optfeature "Required for SessionMiddleware support." dev-python/itsdangerous
	optfeature "Required for SchemaGenerator support." dev-python/pyyaml
	optfeature "Required for GraphQLApp support" media-libs/graphene
	optfeature "Required if you want to use UJSONResponse." dev-python/ujson
	optfeature "Server Sent Events" dev-python/sse-starlette
}

distutils_enable_tests pytest
