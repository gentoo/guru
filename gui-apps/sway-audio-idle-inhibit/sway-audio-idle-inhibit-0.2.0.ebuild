# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

MY_PN="SwayAudioIdleInhibit"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Prevents swayidle from idle when an application is outputting or receiving audio"
HOMEPAGE="https://github.com/ErikReider/SwayAudioIdleInhibit"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ErikReider/SwayAudioIdleInhibit.git"
else
	SRC_URI="https://github.com/ErikReider/SwayAudioIdleInhibit/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="GPL-3"
SLOT="0"

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
