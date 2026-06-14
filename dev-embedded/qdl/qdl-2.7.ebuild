# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Tool to communicate with Qualcomm System On a Chip bootroms"
HOMEPAGE="https://github.com/linux-msm/qdl"
SRC_URI="https://github.com/linux-msm/qdl/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-libs/libusb:1
	dev-libs/libxml2:=
	dev-libs/libzip:=
	test? ( dev-util/cmocka )
"
RDEPEND="${DEPEND}"

BDEPEND="
	sys-apps/help2man
	virtual/pkgconfig
"
src_prepare() {
	sed -i '/default_options/d' meson.build || die
	default
}

src_configure() {
	local emesonargs=(
		-DVERSION="${PV}"
	)
	meson_src_configure
}
