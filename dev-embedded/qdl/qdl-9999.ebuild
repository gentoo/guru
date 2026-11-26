# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson udev

DESCRIPTION="Tool to communicate with Qualcomm System On a Chip bootroms"
HOMEPAGE="https://github.com/qualcomm/qdl"
EGIT_REPO_URI="https://github.com/qualcomm/qdl.git"

LICENSE="BSD"
SLOT="0"
IUSE="nbd test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-libs/libusb:1
	dev-libs/libxml2:=
	dev-libs/libzip:=
	nbd? ( sys-block/nbdkit )
	test? (
		app-arch/zip
		dev-util/cmocka
	)
"
RDEPEND="
	${DEPEND}
	virtual/udev
"

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
		-Dudev=enabled
		$(meson_feature nbd nbdkit)
		$(meson_feature test tests)
	)
	meson_src_configure
}

src_test() {
	meson_src_test \
		--no-suite hil \
		--no-suite hil-vip
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
