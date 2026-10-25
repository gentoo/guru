# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature systemd xdg

DESCRIPTION="File manager from Dux Labs"
HOMEPAGE="https://github.com/duxlabs-dev/dux-files"
SRC_URI="https://github.com/duxlabs-dev/${PN}/releases/download/v${PV}/dfiles-${PV}.tar.gz"

S="${WORKDIR}/dfiles-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	gui-apps/quickshell
"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-lang/go-1.27.1
"

src_prepare(){
	default
	sed -i "s/-s -w //g" core/Makefile || die "failed to remove stripping of debug symbols"
}

src_compile() {
	cd core || die "Failed to cd"
	emake VERSION="${PV}" build
}

src_install() {
	emake DESTDIR="${ED}" PREFIX="/usr" install
	systemd_douserunit assets/systemd/dfiles.service
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature_header "Optional programs for extra features:"
	optfeature "Thumbnailer sandbox" sys-apps/bubblewrap
	optfeature "Video thumbnails" media-video/ffmpegthumbnailer
	optfeature "PDF thumbnails" app-text/poppler
	optfeature "Network shares and removeable drives" gnome-base/gvfs
	optfeature "Devices sidebar" sys-fs/udisks
}
