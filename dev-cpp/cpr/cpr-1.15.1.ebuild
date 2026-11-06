# Copyright 2018-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C++ Requests: Curl for People, a spiritual port of Python Requests"
HOMEPAGE="https://docs.libcpr.dev/"
SRC_URI="https://github.com/libcpr/cpr/archive/${PV}.tar.gz
	-> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ssl"

# tests disabled for now, as it tries to fetch mongoose
RESTRICT="test"

RDEPEND="
	net-misc/curl[ssl?]
"
DEPEND="
	${RDEPEND}
"

src_configure() {
	local mycmakeargs=(
		-DCPR_USE_SYSTEM_CURL=ON
		-DCPR_ENABLE_SSL=$(usex ssl)
	)

	cmake_src_configure
}
