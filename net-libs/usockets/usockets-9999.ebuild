# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="tiny eventing, networking & crypto for async applications"
HOMEPAGE="https://github.com/uNetworking/uSockets"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/uNetworking/uSockets.git"
else
	COMMIT="c06112c89b4c1cf5a09b5f8daa2def756b925889"
	SRC_URI="https://github.com/uNetworking/uSockets/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
	S="${WORKDIR}/uSockets-${COMMIT}"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE="asio libuv +ssl"
REQUIRED_USE="?? ( asio libuv )"

DEPEND="
	asio? ( dev-cpp/asio[ssl?] )
	libuv? ( dev-libs/libuv )
	ssl? ( >=dev-libs/openssl-1.1.0 )
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-0.7.1_p20210909-Makefile.patch"
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

src_install() {
	default
	einstalldocs
	rm -f "${ED}/usr/$(get_libdir)/libusockets.a" || die
}
