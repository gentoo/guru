# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=(python3_{6,7,8} pypy3 )

inherit distutils-r1 eutils

DESCRIPTION="The little ASGI framework that shines."
HOMEPAGE="
	https://www.starlette.io/
	https://github.com/encode/starlette
"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="test? ( dev-python/black[${PYTHON_USEDEP}]
				dev-python/databases[${PYTHON_USEDEP}]
                dev-python/isort[${PYTHON_USEDEP}]
                dev-python/mypy[${PYTHON_USEDEP}] )"

python_prepare_all() {
    # do not install LICENSE to /usr/
	sed -i -e '/data_files/d' setup.py || die

    distutils-r1_python_prepare_all
}

pkg_postinst() {
	optfeature "Required if you want to use FileResponse or StaticFiles" dev-python/aiofiles
	optfeature "Required if you want to use Jinja2Templates" dev-python/jinja2
	optfeature "Required if you want to support form parsing, with request.form()" dev-python/python-multipart
	optfeature "Required for SessionMiddleware support." dev-python/itsdangerous
	optfeature "Required for SchemaGenerator support." dev-python/pyyaml
	optfeature "Required for GraphQLApp support" media-libs/graphene
	optfeature "Required if you want to use UJSONResponse." dev-python/ujson
	optfeature "Server Sent Events" dev-python/sse-starlette
}

distutils_enable_tests pytest
