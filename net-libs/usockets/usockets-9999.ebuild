# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="tiny eventing, networking & crypto for async applications"
HOMEPAGE="https://github.com/uNetworking/uSockets"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/uNetworking/uSockets.git"
else
	COMMIT=7683672d87067cd75b854f4e36b9820f4809a4be
	SRC_URI="https://github.com/uNetworking/uSockets/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
	S="${WORKDIR}/uSockets-${COMMIT}"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE="libuv libressl +ssl static-libs"

DEPEND="ssl? (
		!libressl? ( >=dev-libs/openssl-1.1.0[static-libs?] )
		libressl? ( dev-libs/libressl[static-libs?] )
	)
	libuv? ( dev-libs/libuv[static-libs?] )
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-0.6.0-Makefile.patch"
)

src_compile() {
	tc-export CC CXX
	# the Makefile uses environment variables
	emake VERSION=${PV} \
		  LIB="$(get_libdir)" \
		  WITH_OPENSSL=$(usex ssl 1 0) \
		  WITH_LIBUV=$(usex libuv 1 0) \
		  default
}

src_install() {
	emake LIB="$(get_libdir)" \
		  prefix="${EPREFIX%/}/usr" \
		  DESTDIR="${D}" \
		  VERSION=${PV} \
		  install
	einstalldocs
	if ! use static-libs; then
		rm -f "${ED}/usr/$(get_libdir)/libusockets.a" || die
	fi
}
