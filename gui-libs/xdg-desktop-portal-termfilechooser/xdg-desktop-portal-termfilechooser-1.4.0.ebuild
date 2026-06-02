# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="xdg-desktop-portal backend for choosing files with your favorite file chooser"
HOMEPAGE="https://github.com/hunkyburrito/xdg-desktop-portal-termfilechooser"
SRC_URI="https://github.com/hunkyburrito/xdg-desktop-portal-termfilechooser/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	sys-apps/xdg-desktop-portal
	dev-libs/inih
"

RDEPEND="
	${DEPEND}
"

BDEPEND="app-text/scdoc"
