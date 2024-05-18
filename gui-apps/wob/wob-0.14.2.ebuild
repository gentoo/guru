# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Lightweight overlay volume/backlight/progress/anything bar for Wayland"
HOMEPAGE="https://github.com/francma/wob"
SRC_URI="https://github.com/francma/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+man +seccomp"

RDEPEND="dev-libs/wayland"
DEPEND="${RDEPEND}
	dev-libs/inih
	dev-libs/wayland-protocols
	seccomp? ( sys-libs/libseccomp )
"
BDEPEND="
	dev-util/wayland-scanner
	man? ( app-text/scdoc )
"

src_configure() {
	local emesonargs=(
		$(meson_feature man man-pages)
		$(meson_feature seccomp)
	)
	meson_src_configure
}
