# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake go-module git-r3

EGIT_REPO_URI="https://github.com/google/boringssl"
EGIT_BRANCH="fips-${PV}"

DESCRIPTION="BoringSSL is a fork of OpenSSL that is designed to meet Google's needs."
HOMEPAGE="https://github.com/google/boringssl"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs"

DEPEND="
	dev-libs/openssl:=[static-libs=]
"

PATCHES=(
	"${FILESDIR}"/fix-${PN}-collisions-openssl.patch
)

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=$(usex !static-libs)
	)
	cmake_src_configure
}

pkg_preinst() {
	mkdir -p ${D}/usr/lib64/boringssl/
	cp ${WORKDIR}/${PN}-${PV}_build/crypto/libcrypto.so ${D}/usr/lib64/boringssl/libcrypto.so
	cp ${WORKDIR}/${PN}-${PV}_build/ssl/libssl.so ${D}/usr/lib64/boringssl/libssl.so
	return
}
