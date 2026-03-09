# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Tool to communicate with Qualcomm System On a Chip bootroms"
HOMEPAGE="https://github.com/linux-msm/qdl"
SRC_URI="https://github.com/linux-msm/qdl/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/libusb:1
	dev-libs/libxml2:=
"
RDEPEND="${DEPEND}"

BDEPEND="
	sys-apps/help2man
	virtual/pkgconfig
"

src_compile() {
	# $(VERSION) needs to be consistent in all make invocations
	export VERSION="${PV}"

	local PKG_CONFIG="$(tc-getPKG_CONFIG)"
	emake CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} $(${PKG_CONFIG} --cflags libxml-2.0 libusb-1.0 || die)" \
		LDFLAGS="${LDFLAGS} $(${PKG_CONFIG} --libs libxml-2.0 libusb-1.0 || die)"
	emake manpages
}

src_test() {
	emake tests
}

src_install() {
	emake prefix="${EPREFIX}/usr" DESTDIR="${D}" install
	doman *.1
	einstalldocs
}
