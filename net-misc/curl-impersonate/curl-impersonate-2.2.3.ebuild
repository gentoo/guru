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
	https://github.com/google/boringssl/archive/${BORINGSSL_V}.tar.gz -> boringssl-${BORINGSSL_V}.tar.gz
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
IUSE="static-libs"

src_prepare() {
	cmake_src_prepare

	sed -e "/^  URL/d" \
		-e "/^  URL_HASH/d" \
		-i "CMakeLists.txt" || die

	mkdir -p "${BUILD_DIR}/deps/downloads" || die
	ln -s "${DISTDIR}/libidn2-${LIBIDN2_V}.tar.gz" "${BUILD_DIR}/deps/downloads" || die

	mkdir -p "${BUILD_DIR}/deps/src" || die
	ln -fs "${WORKDIR}/boringssl-${BORINGSSL_V}" "${BUILD_DIR}/deps/src/boringssl" || die
	ln -fs "${WORKDIR}/brotli-${BROTLI_V}" "${BUILD_DIR}/deps/src/brotli" || die
	ln -fs "${WORKDIR}/c-ares-${CARES_V}" "${BUILD_DIR}/deps/src/cares" || die
	ln -fs "${WORKDIR}/curl-curl-${CURL_V//./_}" "${BUILD_DIR}/deps/src/curl" || die
	ln -fs "${WORKDIR}/nghttp2-${NGHTTP2_V}" "${BUILD_DIR}/deps/src/nghttp2" || die
	ln -fs "${WORKDIR}/nghttp3-${NGHTTP3_V}" "${BUILD_DIR}/deps/src/nghttp3" || die
	ln -fs "${WORKDIR}/ngtcp2-${NGTCP2_V}" "${BUILD_DIR}/deps/src/ngtcp2" || die
	ln -fs "${WORKDIR}/zlib-${ZLIB_V}" "${BUILD_DIR}/deps/src/zlib" || die
	ln -fs "${WORKDIR}/zstd-${ZSTD_V}" "${BUILD_DIR}/deps/src/zstd" || die

	sed -e 's/set(_toolchain_cmake_args/& "--no-warn-unused-cli"/' \
		-i "CMakeLists.txt" || die

	if ! use static-libs; then
		sed -e '/libcurl-impersonate\*\.a/d' \
			-i "CMakeLists.txt" || die
	fi

	emake prepare-libidn2 BUILD_DIR="${BUILD_DIR}"
}

src_install() {
	cmake_src_install

	mv "${ED}/usr/include/"{curl,curl-impersonate} || die
}
