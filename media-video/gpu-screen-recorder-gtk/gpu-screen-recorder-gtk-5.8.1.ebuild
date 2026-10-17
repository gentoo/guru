# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://repo.dec05eba.com/gpu-screen-recorder-gtk"
else
	SRC_URI="https://dec05eba.com/snapshot/${PN}.git.${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"
	KEYWORDS="~amd64"
fi

DESCRIPTION="GTK frontend for gpu-screen-recorder"
HOMEPAGE="https://git.dec05eba.com/gpu-screen-recorder-gtk/about"
LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-libs/libayatana-appindicator
	media-video/gpu-screen-recorder
	x11-libs/gtk+:3
"
RDEPEND="${DEPEND}"

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
