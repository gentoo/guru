# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://repo.dec05eba.com/gpu-screen-recorder-gtk"
else
	SRC_URI="https://dec05eba.com/snapshot/${PN}.git.${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"
	KEYWORDS="~amd64"
fi

DESCRIPTION="GTK frontend for gpu-screen-recorder."
HOMEPAGE="https://git.dec05eba.com/gpu-screen-recorder-gtk/about"
LICENSE="GPL-3"
SLOT="0"

DEPEND="
	x11-libs/gtk+:3
	dev-libs/libayatana-appindicator
	media-video/gpu-screen-recorder
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_configure() {
	meson_src_configure
}

src_install() {
	meson_src_install
}
