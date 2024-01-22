# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
PYTHON_REQ_USE="ssl"
DISTUTILS_USE_PEP517=poetry
DISTUTILS_EXT=1
inherit databases distutils-r1 optfeature

DESCRIPTION="A fast asyncio MySQL driver"
HOMEPAGE="
	https://pypi.org/project/asyncmy/
	https://github.com/long2ice/asyncmy
"
SRC_URI="https://github.com/long2ice/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
TEST_S="${S}_test"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		${DATABASES_DEPEND[mysql]}
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_unpack() {
	default

	cp -a "${S}" "${TEST_S}" || die
	rm -r "${TEST_S}"/asyncmy || die
}

src_test() {
	emysql --start
	local sockfile=$(emysql --get-sockfile)

	local myargs=(
		--user=root
		--socket="${sockfile}"
		--silent
		--execute="ALTER USER 'root'@'localhost' IDENTIFIED BY '123456';"
	)

	ebegin "Changing database password"
	mysql "${myargs[@]}"
	eend $? || emysql --die "Changing database password failed"

	distutils-r1_src_test
	emysql --stop
}

python_test() {
	cd "${T}" || die
	epytest "${TEST_S}"
}

python_install() {
	distutils-r1_python_install
	find "${ED}"/usr/lib -name '*.md' -delete || die
	find "${ED}"/usr/lib -name LICENSE -delete || die
}

pkg_postinst() {
	optfeature "sha256_password and caching_sha2_password auth methods" dev-python/cryptography
}
