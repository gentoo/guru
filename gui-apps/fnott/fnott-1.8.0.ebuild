# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson systemd verify-sig xdg

DESCRIPTION="Keyboard driven and lightweight Wayland notification daemon"
HOMEPAGE="https://codeberg.org/dnkl/fnott"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/dnkl/fnott.git"
else
	SRC_URI="
		https://codeberg.org/dnkl/fnott/releases/download/${PV}/${P}.tar.gz
		verify-sig? ( https://codeberg.org/dnkl/fnott/releases/download/${PV}/${P}.tar.gz.sig )
	"
	KEYWORDS="~amd64"
fi

LICENSE="MIT ZLIB"
SLOT="0"

RDEPEND="
	dev-libs/wayland
	media-libs/fcft
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libpng:=
	media-libs/nanosvg
	sys-apps/dbus
	x11-libs/pixman
"
DEPEND="
	${RDEPEND}
	dev-libs/tllist
	>=dev-libs/wayland-protocols-1.32
"
BDEPEND="
	dev-util/wayland-scanner
	app-text/scdoc
	verify-sig? ( sec-keys/openpgp-keys-dnkl )
"

VERIFY_SIG_OPENPGP_KEY_PATH=/usr/share/openpgp-keys/dnkl.asc

src_configure() {
	local emesonargs=(
		# always install unit
		-Dsystemd-units-dir="$(systemd_get_userunitdir)"
		-Dsystem-nanosvg=enabled
	)
	meson_src_configure
}

src_install() {
	local DOCS=( CHANGELOG.md README.md )
	meson_src_install

	rm -r "${ED}"/usr/share/doc/"${PN}" || die
}
