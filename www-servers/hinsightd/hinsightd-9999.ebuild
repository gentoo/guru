# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-{1..4} )

inherit git-r3 fcaps

DESCRIPTION="hinsightd a http/1.1 webserver with (hopefully) minimal goals"
HOMEPAGE="https://gitlab.com/tiotags/hin9"
EGIT_REPO_URI="https://gitlab.com/tiotags/hin9.git"
LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="" #+openssl

BDEPEND="
dev-util/ninja
"

RDEPEND="
acct-user/hinsightd
acct-group/hinsightd
sys-libs/liburing
dev-lang/lua:*
sys-libs/zlib
dev-libs/openssl
"

DEPEND="${RDEPEND}"

PATCHES=(
"${FILESDIR}/hinsightd-redefine-directories.patch"
)

#src_configure() {
#}

src_compile() {
	cd build
	ninja || die
}

src_install() {
	newbin "${S}/build/hin9" hinsightd
	newinitd "${FILESDIR}/init.d.sh" hinsightd
	#systemd_dounit "${FILESDIR}/hinsightd.service" # not tested

	insinto /etc/hinsightd
	newins "${S}/workdir/main.lua" hinsightd.lua

	# logrotate
	insinto /etc/logrotate.d
	newins "${FILESDIR}"/logrotate.d.sh hinsightd

	keepdir /var/www/localhost/htdocs
	keepdir /var/log/hinsightd
	keepdir /var/tmp/hinsightd
}

pkg_postinst() {
	fcaps CAP_NET_BIND_SERVICE /usr/bin/hinsightd
}
