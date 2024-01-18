# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit edo databases distutils-r1 optfeature

DESCRIPTION="A Python 3 asyncio Matrix framework"
HOMEPAGE="
	https://pypi.org/project/mautrix/
	https://github.com/mautrix/python
"

# use github tarball for test data
SRC_URI="https://github.com/mautrix/python/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/python-${PV}"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="crypt"
REQUIRED_USE="test? ( crypt )"

RDEPEND="
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/yarl[${PYTHON_USEDEP}]
	crypt? (
		dev-python/python-olm[${PYTHON_USEDEP}]
		dev-python/pycryptodome[${PYTHON_USEDEP}]
		dev-python/unpaddedbase64[${PYTHON_USEDEP}]
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		dev-python/aiosqlite[${PYTHON_USEDEP}]
		dev-python/asyncpg[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/ruamel-yaml[${PYTHON_USEDEP}]
		$(epostgres --get-depend)
	)
"

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/sphinx-rtd-theme

src_test() {
	local -x PGHOST="$(epostgres --get-sockdir)"
	local -x PGPORT="65432"
	local -x PGUSER="postgres"
	local -x MEOW_TEST_PG_URL="postgresql:///meow"

	epostgres --start ${PGPORT}
	edo createdb -U postgres meow

	distutils-r1_src_test
	epostgres --stop
}

pkg_postinst() {
	optfeature "MIME type detection support" dev-python/python-magic
	optfeature "media transcoding support" media-video/ffmpeg
}
