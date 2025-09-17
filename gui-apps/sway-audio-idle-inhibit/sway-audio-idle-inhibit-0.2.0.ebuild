# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Prevents swayidle from idle when an application is outputting or receiving audio"
HOMEPAGE="https://github.com/ErikReider/SwayAudioIdleInhibit"

SRC_URI="https://github.com/ErikReider/SwayAudioIdleInhibit/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/SwayAudioIdleInhibit-${PV}"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64"

IUSE="systemd"

DEPEND="
	dev-libs/wayland
	dev-libs/wayland-protocols
	media-libs/libpulse
	systemd? (
		sys-apps/systemd
	)
	!systemd? (
		sys-auth/elogind
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=(
		-Dlogind-provider="$(usex systemd systemd elogind)"
	)

	meson_src_configure
}

src_install() {
	meson_src_install
	dodoc README.md
}
