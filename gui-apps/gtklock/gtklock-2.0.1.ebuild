# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="GTK-based lockscreen for Wayland"
HOMEPAGE="https://github.com/jovanlanik/gtklock"
SRC_URI="https://github.com/jovanlanik/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="sys-libs/pam
	>=gui-libs/gtk-layer-shell-0.6.0"

BDEPEND="app-text/scdoc"

PATCHES=(
	"${FILESDIR}"/"${P}"-makefile.patch
)
