# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MAX_KV_MAJ="4"
MAX_KV_MIN="13"
MYP="${PN}-v${PV}"

inherit linux-info linux-mod

DESCRIPTION="Userspace support for MMU notifications"
HOMEPAGE="
	https://lkml.org/lkml/2010/4/22/172
	https://github.com/Portals4/ummunotify
"
SRC_URI="https://github.com/Portals4/ummunotify/raw/master/${MYP}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MYP}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( Documentation/ummunotify.txt README )

MODULE_NAMES="ummunot(misc:${S}/driver:${S}/driver)"
BUILD_TARGETS="all"

pkg_pretend() {
	# https://github.com/Portals4/ummunotify/issues/1
	if kernel_is -ge ${MAX_KV_MAJ} ${MAX_KV_MIN}; then
		eerror "Unsupported kernel version"
		die
	fi
}

src_compile() {
	linux-mod_src_compile || die
}

src_install() {
	einstalldocs
	linux-mod_src_install || die
}
