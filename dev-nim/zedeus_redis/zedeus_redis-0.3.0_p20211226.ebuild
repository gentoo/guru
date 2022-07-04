# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

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

BDEPEND="test? ( dev-db/redis )"

set_package_url "https://github.com/zedeus/redis"

src_prepare() {
	default
	mv redis.nimble ${PN}.nimble || die
}

src_test() {
	# Tests that don't require redis, currently broken
	#enim r tests/tawaitorder.nim

	# Tests that require redis
	local redis_pid="${T}"/redis.pid
	local redis_port=6379

	ebegin "Spawning Redis (NOTE: port ${redis_port} must be free)"
	"${EPREFIX}"/usr/sbin/redis-server - <<- EOF > /dev/null
		daemonize yes
		pidfile ${redis_pid}
		port ${redis_port}
		bind 127.0.0.1
	EOF
	eend ${?}

	nimble_src_test

	ebegin "Stopping Redis"
	kill "$(<"${redis_pid}")"
	eend ${?}
}
