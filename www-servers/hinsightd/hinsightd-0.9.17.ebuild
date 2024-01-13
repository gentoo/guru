# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{1..4} luajit )

inherit fcaps lua-single systemd meson linux-info

DESCRIPTION="hinsightd a http/1.1 webserver with (hopefully) minimal goals"
HOMEPAGE="https://tiotags.gitlab.io/hinsightd"
LICENSE="BSD"
SLOT="0"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/tiotags/hin9.git"
elif [[ ! -z "${mycommit}" ]]; then
	SRC_URI="https://gitlab.com/tiotags/hin9/-/archive/${mycommit}/hin9-${mycommit}.tar.bz2"
	S="${WORKDIR}/hin9-${mycommit}"
else
	SRC_URI="https://gitlab.com/tiotags/hin9/-/archive/v${PV}/hin9-v${PV}.tar.bz2"
	S="${WORKDIR}/hin9-v${PV}"
fi

if [[ ${PV} != *9999* ]]; then
	KEYWORDS="~amd64"
fi

IUSE="+ssl cgi +fcgi +rproxy +ffcall"
REQUIRED_USE="${LUA_REQUIRED_USE}"

BDEPEND="
	dev-build/meson
	virtual/pkgconfig
"

RDEPEND="
	${LUA_DEPS}
	acct-user/hinsightd
	acct-group/hinsightd
	sys-libs/liburing
	sys-libs/zlib
	virtual/libcrypt
	ssl? ( dev-libs/openssl )
	ffcall? ( dev-libs/ffcall )
"

DEPEND="${RDEPEND}"

FILECAPS=(
	cap_net_bind_service usr/sbin/${PN}
)

pkg_setup() {
	linux-info_pkg_setup
	lua-single_pkg_setup
}

src_configure() {
	version=$(ver_cut 1-2 $(lua_get_version))
	if [[ "${version}" == "2.1" ]]; then
		version="jit"
	fi
	local emesonargs=(
		$(meson_use ssl openssl)
		$(meson_use cgi)
		$(meson_use fcgi)
		$(meson_use rproxy)
		$(meson_use ffcall)
		-Dforce-lua-version=${version}
	)
	meson_src_configure
}

src_install() {
	meson_src_install

	newinitd "${S}/external/packaging/${PN}.initd.sh" ${PN}
	newconfd "${S}/external/packaging/${PN}.confd.sh" ${PN}
	systemd_dounit "${FILESDIR}/${PN}.service" # not tested

	# config
	insinto /etc/${PN}
	doins "${S}/workdir/main.lua"
	doins "${S}/workdir/lib.lua"
	doins -r "${S}/workdir/config/"

	# logrotate
	insinto /etc/logrotate.d
	newins "${S}/external/packaging/${PN}.logrotate.sh" ${PN}
}

pkg_postinst() {
	fcaps_pkg_postinst

	if kernel_is lt 5 7; then
		ewarn ""
		ewarn "hinsightd requires io_uring and kernel ~5.6.0"
		ewarn ""
	fi
}
