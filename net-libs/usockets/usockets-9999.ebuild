# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="tiny eventing, networking & crypto for async applications"
HOMEPAGE="https://github.com/uNetworking/uSockets"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/uNetworking/uSockets.git"
	EGIT_SUBMODULES=( '-*' ) # We don't use any of bundled libraries from submodules
else
	SRC_URI="https://github.com/uNetworking/uSockets/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
	S="${WORKDIR}/uSockets-${PV}"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE="asio libuv +ssl"
REQUIRED_USE="?? ( asio libuv )"
# Our only half-assed test requires ssl
RESTRICT="!ssl? ( test )"

DEPEND="
	asio? ( dev-cpp/asio:= )
	libuv? ( dev-libs/libuv )
	ssl? ( >=dev-libs/openssl-1.1.0 )
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-0.8.8-Makefile.patch"
	"${FILESDIR}/${PN}-0.8.1_p20211023-pkg-config.patch"
	"${FILESDIR}/${PN}-0.8.1_p20211023-gen-ssl-config.patch"
	"${FILESDIR}/${PN}-0.8.8-hammer-test.patch"
)

src_configure() {
	tc-export CC CXX AR
	export VERSION="${PV%_*}" \
		LIB="$(get_libdir)" \
		WITH_OPENSSL="$(usex ssl 1 0)" \
		WITH_LIBUV="$(usex libuv 1 0)" \
		WITH_ASIO="$(usex asio 1 0)"
	default
}

src_test() {
	local saved_ulimit=$(ulimit -n)
	# see https://bugs.gentoo.org/820296
	if ! ulimit -n 10240; then
		ewarn "Failed to set ulimit; ${PN} require ulimit -n 10240 to reliably pass tests"
		ulimit -n 2048 || die "${PN} requires ulimit -n set to at least 2048 for tests"
	fi

	emake test
	ulimit -n "${saved_ulimit}" || die "Failed restore ulimit to its original value"
}

src_install() {
	default
	einstalldocs
	rm -f "${ED}/usr/$(get_libdir)/libusockets.a" || die
}
