# Copyright 2019-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson verify-sig

DESCRIPTION="xrandr clone for wlroots compositors"
HOMEPAGE="https://gitlab.freedesktop.org/emersion/wlr-randr"
SRC_URI="https://gitlab.freedesktop.org/emersion/${PN}/-/releases/v${PV}/downloads/${P}.tar.gz
	verify-sig? ( https://gitlab.freedesktop.org/emersion/${PN}/-/releases/v${PV}/downloads/${P}.tar.gz.sig )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64"

DEPEND="dev-libs/wayland"
RDEPEND="${DEPEND}"
BDEPEND="
	app-text/scdoc
	dev-util/wayland-scanner
	virtual/pkgconfig
	verify-sig? ( sec-keys/openpgp-keys-emersion )
"

VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/openpgp-keys/emersion.asc"

src_prepare() {
	default
	sed -i 's/werror=true/werror=false/' meson.build || die
}
