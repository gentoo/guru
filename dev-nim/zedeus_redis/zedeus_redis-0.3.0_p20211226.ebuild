# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit databases nimble

MY_PN="redis"
COMMIT="d0a0e6fb3010015f0cc483ca2e540ace02446570"
DESCRIPTION="Fork of the official redis client for Nim"
HOMEPAGE="https://github.com/zedeus/redis"
SRC_URI="https://github.com/zedeus/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

LICENSE="MIT"
SLOT="$(ver_cut 1-3)"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( ${DATABASES_DEPEND[redis]} )"

set_package_url "https://github.com/zedeus/redis"

src_prepare() {
	default
	mv redis.nimble ${PN}.nimble || die
}

src_test() {
	# Tests that don't require redis, currently broken
	#enim r tests/tawaitorder.nim

	# Tests that require redis
	eredis --start
	nimble_src_test
	eredis --stop
}
