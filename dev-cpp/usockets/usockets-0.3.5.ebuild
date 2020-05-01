# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib

DESCRIPTION="tiny eventing, networking & crypto for async applications"
HOMEPAGE="https://github.com/uNetworking/uSockets"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/uNetworking/uSockets.git"
else
	SRC_URI="https://github.com/uNetworking/uSockets/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
	S="${WORKDIR}/uSockets-${PV}"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE="libuv +openssl libressl debug"

DEPEND="openssl? (
			  libressl? ( >=dev-libs/libressl-3.0.0 )
			  !libressl? ( >=dev-libs/openssl-1.1.0 )
			  )
	libuv? ( dev-libs/libuv )
	debug? (
		|| (
			>=sys-devel/gcc-7.4.0[sanitize]
			(
				sys-devel/clang-runtime[sanitize]
				sys-libs/compiler-rt-sanitizers[sanitize]
			)
		)
	)
"
BDEPEND="${DEPEND}"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/usockets-Makefile.patch"
)

src_compile() {
	# the Makefile uses environment variables
	emake WITH_OPENSSL=$(usex openssl 1 0) \
		  WITH_LIBUV=$(usex libuv 1 0) \
		  WITH_ASAN=$(usex debug 1 0) \
		  default
}

src_install() {
	emake libdir="/usr/$(get_libdir)" prefix="/usr" DESTDIR="${D}" install
	einstalldocs
}
