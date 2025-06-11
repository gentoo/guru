# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C99 implementation of the vnd.amazon.eventstream content-type"
HOMEPAGE="https://github.com/awslabs/aws-c-event-stream"
SRC_URI="https://github.com/awslabs/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs test"

RESTRICT="!test? ( test )"

DEPEND="
	dev-libs/aws-c-common:0=[static-libs=]
	dev-libs/aws-c-io:0=[static-libs=]
	dev-libs/aws-checksums:0=[static-libs=]
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=$(usex !static-libs)
		-DBUILD_TESTING=$(usex test)
	)

	if use test; then
		# (#760585) Due to network sandboxing of portage, internet connectivity
		# tests will always fail. If you need a USE flag, because you want/need
		# to perform these tests manually, please open a bug report for it.
		mycmakeargs+=(
			-DENABLE_NET_TESTS=OFF
		)
	fi

	cmake_src_configure
}
