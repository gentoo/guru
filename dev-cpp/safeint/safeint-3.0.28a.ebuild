# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A class library for C++ that manages integer overflows"
HOMEPAGE="https://github.com/dcleblanc/SafeInt"
SRC_URI="https://github.com/dcleblanc/SafeInt/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/SafeInt-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

PATCHES=(
	"${FILESDIR}/${PN}-3.0.28a-install-the-library.patch"
	"${FILESDIR}/${PN}-3.0.28a-make-tests-optional.patch"
	"${FILESDIR}/${PN}-3.0.28a-remove-broken-tests.patch"
)

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
	)

	cmake_src_configure
}
