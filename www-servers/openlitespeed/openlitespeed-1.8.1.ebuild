# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

BORINGSSL_COMMIT="15655052e8701f908937204785eaa8cd4363099f"

DESCRIPTION="LiteSpeed QUIC (LSQUIC) Library"
HOMEPAGE="https://github.com/litespeedtech/lsquic/"
SRC_URI="
	https://github.com/litespeedtech/openlitespeed/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/google/boringssl/archive/${BORINGSSL_COMMIT}.tar.gz -> boringssl-fips-20230428.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

IUSE="static-libs ruby"
RESTRICT=""

DEPEND="
	dev-lang/go
	dev-libs/modsecurity
	app-arch/brotli
	dev-libs/yajl
	virtual/libcrypt
	ruby? ( dev-lang/ruby )
	dev-libs/lsquic:=[static-libs=]
	dev-libs/ls-qpack:=[static-libs=]
	dev-libs/ls-hpack:=[static-libs=]
"

RDEPEND="
    acct-user/lsadm
    acct-group/lsadm"

PATCHES=(
	"${FILESDIR}"/${PN}-link-boringssl-static-libs.patch
	"${FILESDIR}"/${PN}-disable-build-deps-libs.patch
	"${FILESDIR}"/${PN}-add-install-files.patch
)

src_unpack() {
	default
	unpack boringssl-fips-20230428.tar.gz
	mv boringssl-${BORINGSSL_COMMIT} "${S}"/src/boringssl || die
}

src_configure() {
	# LSWS variables
	SERVERROOT=/usr/local/lsws
	OPENLSWS_USER=nobody
	OPENLSWS_GROUP=nobody
	OPENLSWS_EMAIL=root@localhost
	OPENLSWS_ADMINPORT=7080
	DEFAULT_TMP_DIR=/tmp/lshttpd
	if use ruby ; then
		RUBY_PATH=/usr/bin/ruby
	else
		RUBY_PATH=
	fi
	OPENLSWS_EXAMPLEPORT=8088

	sed -e "s/%ADMIN_PORT%/$OPENLSWS_ADMINPORT/" "${S}/dist/admin/conf/admin_config.conf.in" > "${S}/dist/admin/conf/admin_config.conf"
	sed -e "s/%USER%/$OPENLSWS_USER/" -e "s/%GROUP%/$OPENLSWS_GROUP/" -e "s#%DEFAULT_TMP_DIR%#$DEFAULT_TMP_DIR#"  -e "s/%ADMIN_EMAIL%/$OPENLSWS_EMAIL/" -e "s/%HTTP_PORT%/$OPENLSWS_EXAMPLEPORT/" -e "s/%RUBY_BIN%/$RUBY_PATH/"  "${S}/dist/conf/httpd_config.conf.in" > "${S}/dist/conf/httpd_config.conf"
    sed "s:%LSWS_CTRL%:$SERVERROOT/bin/lswsctrl:" "${S}/dist/admin/misc/lsws.rc.in" > "${S}/dist/admin/misc/lsws.rc"
    sed "s:%LSWS_CTRL%:$SERVERROOT/bin/lswsctrl:" "${S}/dist/admin/misc/lsws.rc.gentoo.in" > "${S}/dist/admin/misc/lsws.rc.gentoo"
    sed "s:%LSWS_CTRL%:$SERVERROOT/bin/lswsctrl:" "${S}/dist/admin/misc/lshttpd.service.in" > "${S}/dist/admin/misc/lshttpd.service"

	local mycmakeargs=(
	)
	cmake_src_configure
}
