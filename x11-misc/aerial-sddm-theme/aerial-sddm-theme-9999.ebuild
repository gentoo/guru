# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="SDDM theme with Apple TV Aerial videos"
HOMEPAGE="https://github.com/3ximus/aerial-sddm-theme"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/3ximus/aerial-sddm-theme.git"
else
	COMMIT=1a8a5ba00aa4a98fcdc99c9c1547d73a2a64c1bf
	SRC_URI="https://github.com/3ximus/aerial-sddm-theme/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-${COMMIT}"
fi

LICENSE="GPL-2"
SLOT="0"

RDEPEND="
	media-libs/gst-plugins-good
	dev-qt/qtmultimedia:=[alsa,gstreamer,qml,widgets]
	dev-qt/qtgraphicaleffects
	dev-qt/qtquickcontrols
"

src_install() {
	insinto /usr/share/sddm/themes/aerial
	doins -r components playlists screens Main.qml theme.conf theme.conf.user
}
