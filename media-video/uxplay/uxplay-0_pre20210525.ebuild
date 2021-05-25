# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

GIT_PN="UxPlay"

inherit cmake

DESCRIPTION="AirPlay Unix mirroring server"
HOMEPAGE="https://github.com/antimof/UxPlay"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/antimof/${GIT_PN}.git"
	inherit git-r3
else
	EGIT_COMMIT="6a473d6026480c47b6d9f1b2d619039da3cd36ba"
	SRC_URI="https://github.com/antimof/${GIT_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${GIT_PN}-${EGIT_COMMIT}"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	dev-libs/openssl
	media-libs/gstreamer
	media-libs/gst-plugins-bad
	media-plugins/gst-plugins-libav
	net-dns/avahi[mdnsresponder-compat]
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/${P}-fix-installation.patch"
	"${FILESDIR}/${P}-fix-screen-sharing.patch"
	"${FILESDIR}/${P}-use-machine-hostname.patch"
)
