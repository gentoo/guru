# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson verify-sig

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/dnkl/fuzzel.git"
else
	SRC_URI="
		https://codeberg.org/dnkl/fuzzel/releases/download/${PV}/${P}.tar.gz
		verify-sig? ( https://codeberg.org/dnkl/fuzzel/releases/download/${PV}/${P}.tar.gz.sig )
	"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Application launcher for wlroots based Wayland compositors."
HOMEPAGE="https://codeberg.org/dnkl/fuzzel"
LICENSE="MIT"
SLOT="0"
IUSE="png svg"

RDEPEND="
	dev-libs/wayland
	<media-libs/fcft-4.0.0
	>=media-libs/fcft-3.3.1
	media-libs/fontconfig
	x11-libs/libxkbcommon
	>=x11-libs/pixman-0.46.0
	png? ( media-libs/libpng:= )
	svg? ( media-libs/nanosvg )
"
DEPEND="
	${RDEPEND}
	>=dev-libs/tllist-1.0.1
	>=dev-libs/wayland-protocols-1.41
"
BDEPEND="
	app-text/scdoc
	dev-util/wayland-scanner
	verify-sig? ( sec-keys/openpgp-keys-dnkl )
"

VERIFY_SIG_OPENPGP_KEY_PATH=/usr/share/openpgp-keys/dnkl.asc

src_configure() {
	local emesonargs=(
		# cairo is not required with nanosvg
		-Denable-cairo=disabled
		-Dpng-backend=$(usex png libpng none)
		-Dsvg-backend=$(usex svg nanosvg none)
		$(meson_feature svg system-nanosvg)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	rm -rf "${ED}/usr/share/doc/fuzzel" || die
}
