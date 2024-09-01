# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DESCRIPTION="Pre-compiled talosctl is an tool for interacting with the Talos API"
HOMEPAGE="https://www.talos.dev/v1.7/"
SLOT="0"
S="${WORKDIR}"
LICENSE="MPL-2.0"
KEYWORDS="~amd64 ~arm ~arm64"
SRC_URI="
        amd64? ( https://github.com/siderolabs/talos/releases/download/v${PV}/talosctl-linux-amd64 -> talosctl-amd64-v${PV} )
        arm64? ( https://github.com/siderolabs/talos/releases/download/v${PV}/talosctl-linux-arm64 -> talosctl-arm64-v${PV} )
        arm? ( https://github.com/siderolabs/talos/releases/download/v${PV}/talosctl-linux-armv7 -> talosctl-armv7-v${PV} )
"

src_install() {
        if use arm; then
          newbin "${DISTDIR}"/talosctl-armv7-v${PV} talosctl
        fi
        if use arm64; then
          newbin "${DISTDIR}"/talosctl-arm64-v${PV} talosctl
        fi
        if use amd64; then
          newbin "${DISTDIR}"/talosctl-amd64-v${PV} talosctl
        fi
}
