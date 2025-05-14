# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MO_PV="mo1"
DESCRIPTION="MoneroOcean fork of xmrig that supports algo switching"
HOMEPAGE="https://github.com/MoneroOcean/xmrig"
SRC_URI="https://github.com/MoneroOcean/xmrig/archive/v${PV}-${MO_PV}.tar.gz -> ${P}-${MO_PV}.tar.gz"
KEYWORDS="~amd64 ~arm64"

LICENSE="Apache-2.0 GPL-3+ MIT"
SLOT="0"
IUSE="cpu_flags_x86_sse4_1 donate hwloc opencl +ssl"

DEPEND="
	dev-libs/libuv:=
	hwloc? ( >=sys-apps/hwloc-2.5.0:= )
	opencl? ( virtual/opencl )
	ssl? ( dev-libs/openssl:= )
"

RDEPEND="
	${DEPEND}
	!arm64? ( sys-apps/msr-tools )
"

PATCHES=(
	"${FILESDIR}"/${PN}-6.12.2-nonotls.patch
)

S="${WORKDIR}/xmrig-${PV}-${MO_PV}"

src_prepare() {
	if ! use donate ; then
		sed -i 's/1;/0;/g' src/donate.h || die
	fi

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWITH_SSE4_1=$(usex cpu_flags_x86_sse4_1)
		-DWITH_HWLOC=$(usex hwloc)
		-DWITH_TLS=$(usex ssl)
		-DWITH_OPENCL=$(usex opencl)
		-DWITH_CUDA=OFF
	)

	cmake_src_configure
}

src_install() {
	default
	newbin "${BUILD_DIR}/xmrig" xmrig-mo
}
