# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Repodata downloading library"
HOMEPAGE="https://github.com/rpm-software-management/librepo"
SRC_URI="https://github.com/rpm-software-management/librepo/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc gpgme test +zchunk"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-libs/glib-2.66:2
	dev-libs/libxml2
	dev-libs/openssl:=
	>=net-misc/curl-7.52.0
	gpgme? ( app-crypt/gpgme:1= )
	!gpgme? ( >=app-arch/rpm-4.18.0 )
	zchunk? ( >=app-arch/zchunk-0.9.11 )
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
	doc? ( app-text/doxygen )
	test? ( dev-libs/check )
"

src_prepare() {
	cmake_src_prepare

	# respect temp directory during tests, bug #924463
	sed -i "s|/tmp/|${T}/|" tests/testsys.h || die
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_PYTHON=OFF
		-DENABLE_SELINUX=OFF
		-DUSE_GPGME=$(usex gpgme)
		-DENABLE_DOCS=$(usex doc)
		-DENABLE_TESTS=$(usex test)
		-DWITH_ZCHUNK=$(usex zchunk)
	)
	cmake_src_configure
}
