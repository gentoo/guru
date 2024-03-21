# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit optfeature toolchain-funcs vala xdg

DESCRIPTION="A system restore utility for Linux"
HOMEPAGE="https://github.com/teejee2008/timeshift"
SRC_URI="https://github.com/teejee2008/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-libs/json-glib
	dev-libs/libgee
	dev-util/desktop-file-utils
	net-libs/libsoup
	net-misc/rsync
	sys-process/cronie
	x11-libs/gtk+:3
	x11-libs/xapp
"
RDEPEND="${DEPEND}"
BDEPEND="
	$(vala_depend)
	net-misc/rsync
	sys-apps/diffutils
	sys-apps/coreutils
	sys-fs/btrfs-progs
	>=x11-libs/vte-0.60.3[vala]
"

src_prepare() {
#	sed -i -e "s:--thread:& Core/AppExcludeEntry.vala:" "src/makefile"
	sed -i -e "s:valac:valac-$(vala_best_api_version):" "src/makefile"
	vala_setup
	default
}

src_compile() {
	tc-export CC
	# can't use all jobs here, fails to compile because some files getting removed
	# during compilation, which are missing afterwards.
	# https://bugs.gentoo.org/883157
	# Pascal Jäger <pascal.jaeger@leimstift.de> (2022-11-26)
	emake -j1
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "btrfs support" sys-fs/btrfs-progs
}

pkg_postrm() {
	xdg_pkg_postrm
}
