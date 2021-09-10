# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{1..4} luajit )

inherit fcaps lua-single systemd cmake linux-info

DESCRIPTION="hinsightd a http/1.1 webserver with (hopefully) minimal goals"
HOMEPAGE="https://gitlab.com/tiotags/hin9"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/tiotags/hin9.git"
	KEYWORDS=
elif [[ ! -z "$mycommit" ]]; then
	SRC_URI="https://gitlab.com/tiotags/hin9/-/archive/${mycommit}/hin9-${mycommit}.tar.gz"
	S="${WORKDIR}/hin9-${mycommit}"
else
	SRC_URI="https://gitlab.com/tiotags/hin9/-/archive/v${PV}/hin9-v${PV}.tar.gz"
	S="${WORKDIR}/hin9-v${PV}"
fi

IUSE="+openssl cgi +fcgi +rproxy"
REQUIRED_USE="${LUA_REQUIRED_USE}"

BDEPEND="
	dev-util/cmake
	virtual/pkgconfig
"

RDEPEND="
	${LUA_DEPS}
	acct-user/hinsightd
	acct-group/hinsightd
	sys-libs/liburing
	sys-libs/zlib
	virtual/libcrypt
	openssl? ( dev-libs/openssl )
"

DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-defines-v4.patch"
)

FILECAPS=(
	cap_net_bind_service usr/sbin/${PN}
)

src_configure() {
	local mycmakeargs=(
		-DUSE_OPENSSL=$(usex openssl)
		-DUSE_CGI=$(usex cgi)
		-DUSE_FCGI=$(usex fcgi)
		-DUSE_RPROXY=$(usex rproxy)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	newinitd "${S}/external/packaging/$PN.initd.sh" $PN
	newconfd "${S}/external/packaging/$PN.confd.sh" $PN
	systemd_dounit "${FILESDIR}/$PN.service" # not tested

	# config
	insinto /etc/$PN
	doins "${S}/workdir/main.lua"
	doins "${S}/workdir/lib.lua"
	doins "${S}/workdir/default_config.lua"

	# logrotate
	insinto /etc/logrotate.d
	newins "${S}/external/packaging/$PN.logrotate.sh" $PN
}

pkg_postinst() {
	fcaps_pkg_postinst

	if kernel_is lt 5 7; then
		ewarn ""
		ewarn "hinsightd requires io_uring and kernel ~5.6.0"
		ewarn ""
	fi
}
