# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="LiteSpeed QUIC (LSQUIC) Library"
HOMEPAGE="https://github.com/litespeedtech/lsquic/"

# LSQUIC
EGIT_LSQUIC_REPO_URI="https://github.com/litespeedtech/lsquic/"
EGIT_LSQUIC_COMMIT="3bbf683f25ab84826951350c57ae226c88c54422"
EGIT_LSQUIC_CHECKOUT_DIR="${WORKDIR}/${P}/"

# BoringSSL
EGIT_BORINGSSL_REPO_URI="https://github.com/google/boringssl"
EGIT_BORINGSSL_BRANCH="fips-20230428"
EGIT_BORINGSSL_CHECKOUT_DIR="${WORKDIR}/${P}/src/liblsquic/boringssl"

EGIT_SUBMODULES=()

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bin static-libs test"

DEPEND="
	dev-libs/ls-qpack:=[static-libs=]
	dev-libs/ls-hpack:=[static-libs=]
"

PATCHES=(
	"${FILESDIR}"/${PN}-disable-build-deps-libs.patch
	"${FILESDIR}"/${PN}-link-boringssl-static-libs.patch
)

src_unpack() {
	# Checkout LSQUIC Sources
	git-r3_fetch ${EGIT_LSQUIC_REPO_URI} ${EGIT_LSQUIC_COMMIT}
	git-r3_checkout ${EGIT_LSQUIC_REPO_URI} ${EGIT_LSQUIC_CHECKOUT_DIR}
	# Checkout BoringSSL Sources
	git-r3_fetch ${EGIT_BORINGSSL_REPO_URI} ${EGIT_BORINGSSL_BRANCH}
	git-r3_checkout ${EGIT_BORINGSSL_REPO_URI} ${EGIT_BORINGSSL_CHECKOUT_DIR}
}

src_configure() {
	local mycmakeargs=(
		-DLSQUIC_SHARED_LIB=$(usex !static-libs)
		-DLSQUIC_TESTS=$(usex test)
		-DLSQUIC_BIN=$(usex bin)
	)
	cmake_src_configure
}
