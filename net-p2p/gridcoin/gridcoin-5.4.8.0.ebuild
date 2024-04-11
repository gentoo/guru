# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake db-use multilib xdg-utils

DESCRIPTION="Proof-of-Stake based cryptocurrency that rewards BOINC computation"
HOMEPAGE="https://gridcoin.us/ https://gridcoin.world/"
SRC_URI="https://github.com/${PN}-community/${PN^}-Research/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN^}-Research-${PV}"

LICENSE="BSD BSD-2 Boost-1.0 MIT SSLeay"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+asm dbus gui qrcode test +upnp"
IUSE+=" cpu_flags_arm_neon cpu_flags_x86_avx2 cpu_flags_x86_sha cpu_flags_x86_sse4_1"
RESTRICT="!test? ( test )"

REQUIRED_USE="
	dbus? ( gui )
	qrcode? ( gui )
"

BDB_SLOT="5.3"
RDEPEND="
	>=dev-libs/boost-1.63.0:=[zlib(+)]
	>=dev-libs/libsecp256k1-0.2.0:=[recovery(+)]
	>=dev-libs/leveldb-1.21:=
	dev-libs/libzip:=
	dev-libs/openssl:=
	dev-libs/univalue
	net-misc/curl[ssl]
	sys-libs/db:${BDB_SLOT}[cxx]
	gui? (
		dev-qt/qtconcurrent:5
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtnetwork:5
		dev-qt/qtwidgets:5
		dbus? ( dev-qt/qtdbus:5 )
		qrcode? ( media-gfx/qrencode:= )
	)
	upnp? ( net-libs/miniupnpc:= )
"
DEPEND="${RDEPEND}
	test? ( gui? ( dev-qt/qttest:5 ) )
"
BDEPEND="
	virtual/pkgconfig
	gui? ( dev-qt/linguist-tools:5 )
	test? ( app-editors/vim-core )
"
IDEPEND="gui? ( dev-util/desktop-file-utils )"

src_configure() {
	local mycmakeargs=(
		-DENABLE_DAEMON=$(usex !gui)
		-DENABLE_GUI=$(usex gui)
		-DENABLE_TESTS=$(usex test)

		-DENABLE_SSE41=$(usex cpu_flags_x86_sse4_1)
		-DENABLE_AVX2=$(usex cpu_flags_x86_avx2)
		-DENABLE_X86_SHANI=$(usex cpu_flags_x86_sha)
		-DENABLE_ARM_SHANI=$(usex cpu_flags_arm_neon)
		-DUSE_ASM=$(usex asm)

		-DENABLE_QRENCODE=$(usex qrcode)
		-DENABLE_UPNP=$(usex upnp)
		-DDEFAULT_UPNP=$(usex upnp)
		-DUSE_DBUS=$(usex dbus)

		-DSYSTEM_BDB=ON
		-DBerkeleyDB_INCLUDE_DIR="$(db_includedir ${BDB_SLOT})"
		-DBerkeleyDB_CXX_LIBRARY="${ESYSROOT}/usr/$(get_libdir)/libdb_cxx-${BDB_SLOT}$(get_libname)"
		-DSYSTEM_LEVELDB=ON
		-DSYSTEM_SECP256K1=ON
		-DSYSTEM_UNIVALUE=ON
		-DSYSTEM_XXD=ON
	)
	cmake_src_configure
}

pkg_postinst() {
	# we don't use xdg.eclass because it adds unconditional IDEPENDs
	if use gui; then
		xdg_desktop_database_update
		xdg_icon_cache_update
	fi
}

pkg_postrm() {
	if use gui; then
		xdg_desktop_database_update
		xdg_icon_cache_update
	fi
}
