# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A cli to browse and watch anime."
HOMEPAGE="https://github.com/pystardust/ani-cli"
if [[ "${PV}" == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/pystardust/${PN}.git"
	inherit git-r3
else
	SRC_URI="
		https://github.com/pystardust/${PN}/archive/refs/tags/v${PV}.tar.gz
	"
	S="${WORKDIR}/${P}"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	media-video/mpv
	app-shells/fzf
	media-video/ffmpeg
	net-misc/aria2"

RDEPEND="${DEPEND}"

src_install() {
	dobin "${PN}"
	doman "${PN}.1"
}
