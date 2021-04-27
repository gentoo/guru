# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-{1..4} )

inherit fcaps lua-single systemd cmake

DESCRIPTION="hinsightd a http/1.1 webserver with (hopefully) minimal goals"
HOMEPAGE="https://gitlab.com/tiotags/hin9"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/tiotags/hin9.git"
else
	SRC_URI="https://gitlab.com/tiotags/hin9/-/archive/v${PV}/hin9-v${PV}.tar.gz"
	S="${WORKDIR}/hin9-v${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="BSD"
SLOT="0"

IUSE="+openssl"
REQUIRED_USE="${LUA_REQUIRED_USE}"

BDEPEND="
	dev-util/ninja
	dev-util/cmake
	virtual/pkgconfig
"

RDEPEND="
	${LUA_DEPS}
	acct-user/hinsightd
	acct-group/hinsightd
	sys-libs/liburing
	sys-libs/zlib
	openssl? ( dev-libs/openssl )
"

DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/hinsightd-redefine-directories.patch"
	"${FILESDIR}/hinsightd-default-config.patch"
)

src_configure() {
	local mycmakeargs=(
		-DUSE_OPENSSL=$(usex openssl)
	)
	cmake_src_configure
}

src_install() {
	newbin "${BUILD_DIR}/hin9" hinsightd
	newinitd "${FILESDIR}/init.d.sh" hinsightd
	systemd_dounit "${FILESDIR}/hinsightd.service" # not tested

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
