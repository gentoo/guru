# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Library to interface with USB Type-C/Power Delivery devices"
HOMEPAGE="https://github.com/libtypec/libtypec"
SRC_URI="https://github.com/libtypec/libtypec/archive/refs/tags/${P}.tar.gz"

PATCHES=(
	"${FILESDIR}"/${PN}-0.5.1-meson-fix-build-based-on-Gentoo-testing.patch
	"${FILESDIR}"/${PN}-0.5.1-meson.build-reduce-version-duplication.patch
	"${FILESDIR}"/${PN}-0.5.1-meson.build-install-lib-and-headers.patch
)

S="${WORKDIR}/${PN}-${P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	virtual/pkgconfig
"
DEPEND="
	virtual/libudev
"
RDEPEND="
	${DEPEND}
	!<dev-libs/libtypec-0.5.1-r1
"
