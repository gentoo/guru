# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Lightweight overlay volume/backlight/progress/anything bar for Wayland"
HOMEPAGE="https://github.com/francma/wob"
SRC_URI="https://github.com/francma/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+man +seccomp test"
RESTRICT="!test? ( test )"

RDEPEND="dev-libs/wayland"
DEPEND="${RDEPEND}
	dev-libs/wayland-protocols
	seccomp? ( sys-libs/libseccomp )
"
BDEPEND="
	dev-util/wayland-scanner
	man? ( app-text/scdoc )
	test? ( dev-util/cmocka )
"

src_configure() {
	local emesonargs=(
		$(meson_feature man man-pages)
		$(meson_feature seccomp)
		$(meson_feature test tests)
	)
	meson_src_configure
}
