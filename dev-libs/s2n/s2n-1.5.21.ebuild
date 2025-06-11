# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Simple, small, fast and secure C99 implementation of the TLS/SSL protocols"
HOMEPAGE="https://github.com/awslabs/s2n"
SRC_URI="https://github.com/awslabs/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs test"

RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/openssl:0=[static-libs=]
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-tls-${PV}"

src_prepare() {
	cmake_src_prepare

	# Fix shared library building, needed for USE="test"
	# See: https://github.com/awslabs/s2n/issues/2401
	if use test; then
		sed -i -e 's, -fvisibility=hidden,,' "${S}"/CMakeLists.txt || die "sed failed"
		# Remove s2n_self_talk_nonblocking_test, it is broken.
		# See: https://github.com/awslabs/s2n/issues/2051#issuecomment-744543724
		rm "${S}"/tests/unit/s2n_self_talk_nonblocking_test.c || die
	fi
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=$(usex !static-libs)
		-DBUILD_TESTING=$(usex test)
		-DUNSAFE_TREAT_WARNINGS_AS_ERRORS=OFF
	)
	cmake_src_configure
}
