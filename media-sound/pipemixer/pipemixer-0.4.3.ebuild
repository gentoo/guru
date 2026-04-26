# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Lightweight TUI volume control for PipeWire"
HOMEPAGE="https://github.com/heather7283/pipemixer"
SRC_URI="https://github.com/heather7283/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-lang/rust
	dev-util/meson
"
RDEPEND="${DEPEND}"

src_configure() {
	meson_src_configure
}

pkg_postinst() {
	elog "Run 'pipemixer' to start the TUI."
}
