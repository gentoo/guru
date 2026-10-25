# Copyright 2024-2026 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Daemonless replacement for libudev"
HOMEPAGE="https://github.com/illiliti/libudev-zero"
SRC_URI="https://github.com/illiliti/libudev-zero/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	!sys-apps/systemd-utils[udev]
	sys-apps/hwdata
"

src_configure() {
	local emesonargs=(
		-Ddefault_library=shared
	)

	meson_src_configure
}
