# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Configurable TUI clipboard manager for Unix, built for Wayland"
HOMEPAGE="https://github.com/savedra1/clipse"

SRC_URI="
	https://github.com/savedra1/clipse/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/sat0sh1c/clipse_tarball/releases/download/${P}/${P}-vendor.tar.xz
"
LICENSE="Apache-2.0 BSD-2 BSD ISC MIT WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="test"

# Only the wayland backend is built (see upstream Makefile);
RDEPEND="gui-apps/wl-clipboard"

src_compile() {
	export CGO_ENABLED=0
	ego build -tags wayland -o "${PN}"
}

src_test() {
	ego test -tags wayland ./...
}

src_install() {
	dobin "${PN}"

	dodoc README.md CHANGELOG.md
}

pkg_postinst() {
	elog "clipse requires a background listener to record clipboard history,"
	elog "e.g. by running 'clipse -listen' from your compositor/WM autostart."
	elog "See ${HOMEPAGE} for configuration and keybinding examples."
}
