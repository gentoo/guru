# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo desktop xdg

DESCRIPTION="A screenshot annotation tool inspired by Swappy and Flameshot."
HOMEPAGE="https://github.com/gabm/satty"

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/gabm/Satty.git"
else
	SRC_URI="
		https://github.com/gabm/Satty/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		${CARGO_CRATE_URIS}
	"
	M_PN=Satty
	S="${WORKDIR}/${M_PN}-${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="MPL-2.0"
SLOT="0"

RDEPEND="
	dev-libs/glib:2
	media-libs/fontconfig
	media-libs/libepoxy
	media-libs/mesa[opengl]
	media-libs/graphene
	gui-libs/libadwaita
	gui-libs/gtk:4
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/pango
"

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_unpack() {
	if [[ "${PV}" == 9999 ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_install() {
	dodoc README.md

	dobin "$(cargo_target_dir)"/satty
	#Just add the icon and desktop file
	doicon "${S}/assets/satty.svg"
	domenu "${S}/satty.desktop"
}
