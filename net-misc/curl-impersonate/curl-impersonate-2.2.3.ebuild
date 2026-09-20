# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

BORINGSSL_V="156c7b75ae9b8c3b3f847acf264f17594c3859fb"
BROTLI_V="1.2.0"
CARES_V="1.34.8"
CURL_V="8.22.0"
LIBIDN2_V="2.3.7"
NGHTTP2_V="1.63.0"
NGHTTP3_V="1.15.0"
NGTCP2_V="1.20.0"
ZLIB_V="1.3.1"
ZSTD_V="1.5.7"

DESCRIPTION="Build of curl that impersonates real browsers"
HOMEPAGE="https://github.com/lexiforest/curl-impersonate"
SRC_URI="
	https://github.com/lexiforest/curl-impersonate/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/google/boringssl/archive/${BORINGSSL_V}.zip -> boringssl-${BORINGSSL_V}.zip
	https://github.com/google/brotli/archive/refs/tags/v${BROTLI_V}.tar.gz -> brotli-${BROTLI_V}.tar.gz
	https://github.com/c-ares/c-ares/releases/download/v${CARES_V}/c-ares-${CARES_V}.tar.gz -> cares-${CARES_V}.tar.gz
	https://github.com/curl/curl/archive/curl-${CURL_V//./_}.tar.gz -> curl-${CURL_V}.tar.gz
	mirror://gnu/libidn/libidn2-${LIBIDN2_V}.tar.gz
	https://github.com/nghttp2/nghttp2/releases/download/v${NGHTTP2_V}/nghttp2-${NGHTTP2_V}.tar.bz2
	https://github.com/ngtcp2/nghttp3/releases/download/v${NGHTTP3_V}/nghttp3-${NGHTTP3_V}.tar.bz2
	https://github.com/ngtcp2/ngtcp2/releases/download/v${NGTCP2_V}/ngtcp2-${NGTCP2_V}.tar.bz2
	https://github.com/madler/zlib/releases/download/v${ZLIB_V}/zlib-${ZLIB_V}.tar.gz
	https://github.com/facebook/zstd/releases/download/v${ZSTD_V}/zstd-${ZSTD_V}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_unpack() {
	unpack "${P}.tar.gz"
}

src_prepare() {
	cmake_src_prepare

	sed -e "s#^set(BORINGSSL_URL .*#set(BORINGSSL_URL \"${DISTDIR}/boringssl-${BORINGSSL_V}.zip\")#" \
		-e "s#^set(BROTLI_URL .*#set(BROTLI_URL \"${DISTDIR}/brotli-${BROTLI_V}.tar.gz\")#" \
		-e "s#^set(CARES_URL .*#set(CARES_URL \"${DISTDIR}/cares-${CARES_V}.tar.gz\")#" \
		-e "s#^set(CURL_URL .*#set(CURL_URL \"${DISTDIR}/curl-${CURL_V}.tar.gz\")#" \
		-e "s#^set(NGHTTP2_URL .*#set(NGHTTP2_URL \"${DISTDIR}/nghttp2-${NGHTTP2_V}.tar.bz2\")#" \
		-e "s#^set(NGHTTP3_URL .*#set(NGHTTP3_URL \"${DISTDIR}/nghttp3-${NGHTTP3_V}.tar.bz2\")#" \
		-e "s#^set(NGTCP2_URL .*#set(NGTCP2_URL \"${DISTDIR}/ngtcp2-${NGTCP2_V}.tar.bz2\")#" \
		-e "s#^set(ZLIB_URL .*#set(ZLIB_URL \"${DISTDIR}/zlib-${ZLIB_V}.tar.gz\")#" \
		-e "s#^set(ZSTD_URL .*#set(ZSTD_URL \"${DISTDIR}/zstd-${ZSTD_V}.tar.gz\")#" \
		-i "CMakeLists.txt" || die

	mkdir -p "${BUILD_DIR}/deps/downloads" || die
	ln -s "${DISTDIR}/libidn2-${LIBIDN2_V}.tar.gz" "${BUILD_DIR}/deps/downloads"
	make prepare-libidn2 BUILD_DIR="${BUILD_DIR}"
}

src_install() {
	cmake_src_install

	mv "${ED}/usr/include/"{curl,curl-impersonate} || die
}
