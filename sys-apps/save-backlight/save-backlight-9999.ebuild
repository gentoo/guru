# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit prefix

DESCRIPTION="An OpenRC service for restoring the last brightness level on reboot"
HOMEPAGE="https://github.com/beatussum/save-backlight/"

if [[ "${PV}" = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/beatussum/save-backlight.git"
else
	SRC_URI="https://github.com/beatussum/save-backlight/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3+"
SLOT="0"

RDEPEND="sys-apps/openrc"

src_prepare() {
	default
	hprefixify save-backlight
}

src_compile() { :; }

src_install() {
	einstalldocs
	emake DESTDIR="${ED}" PREFIX="" install
}
