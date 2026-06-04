# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson systemd

DESCRIPTION="xdg-desktop-portal backend for choosing files with your favorite file chooser"
HOMEPAGE="https://github.com/hunkyburrito/xdg-desktop-portal-termfilechooser"
SRC_URI="https://github.com/hunkyburrito/xdg-desktop-portal-termfilechooser/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	sys-apps/xdg-desktop-portal
	dev-libs/inih
	|| (
		sys-auth/elogind
		sys-apps/systemd
		sys-libs/basu
	)
"

RDEPEND="
	${DEPEND}
"

BDEPEND="app-text/scdoc"

src_install() {
	dodoc Compatibility.md
	systemd_newunit contrib/systemd/xdg-desktop-portal-termfilechooser.service.in \
		xdg-desktop-portal-termfilechooser.service
	rm -r contrib/systemd || die

	meson_src_install
}
