# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="OBS Studio VAAPI support via GStreamer"
HOMEPAGE="https://github.com/fzwoch/obs-vaapi"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fzwoch/obs-vaapi"
else
	SRC_URI="https://github.com/fzwoch/obs-vaapi/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="video_cards_amdgpu video_cards_intel"
RDEPEND=">=media-libs/gst-plugins-bad-1.22.3-r3[vaapi]
	media-video/obs-studio
	video_cards_amdgpu? ( media-libs/mesa[vaapi,video_cards_radeonsi] )
	video_cards_intel? ( media-libs/libva-intel-media-driver )
"
DEPEND="${RDEPEND}"

src_configure() {
	local emesonargs+=(
	--libdir=/usr/$(get_libdir)/obs-plugins
	)
	meson_src_configure
}
