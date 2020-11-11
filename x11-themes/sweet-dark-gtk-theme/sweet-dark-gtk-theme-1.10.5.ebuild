# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Sweet (dark) gtk theme"
HOMEPAGE="https://github.com/EliverLara/Sweet"
SRC_URI="https://github.com/EliverLara/Sweet/releases/download/v${PV}/Sweet-Dark.zip -> ${P}.zip"
S="${WORKDIR}/Sweet-Dark"

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~ppc-aix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
LICENSE="GPL-3"
SLOT="0"

src_install() {
	insinto /usr/share/themes/Sweet
	doins -r assets gnome-shell gtk-{2,3}.0 \
		  metacity-1 xfwm4 index.theme
}
