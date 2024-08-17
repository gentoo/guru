# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit wrapper desktop

DESCRIPTION="Unofficial Steam AppImage built on top of Conty (Arch Linux), with deps inside"
HOMEPAGE="https://github.com/ivan-hc/Steam-appimage"
SRC_URI="https://github.com/ivan-hc/${PN}/releases/download/continuous/Steam-${PV}.79-2-3-x86_64.AppImage"

S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"

RDEPEND="sys-fs/fuse:0"

QA_PREBUILT="*"

src_install() {
	local file=Steam-${PV}.79-2-3-x86_64.AppImage

	mkdir -p "${ED}/opt/"
	cp "${DISTDIR}/$file" "${ED}/opt/Steam.AppImage" || die
	fperms +x /opt/Steam.AppImage

	make_wrapper ${PN} "env FUSERMOUNT_PROG=\$(command -v fusermount) /opt/Steam.AppImage"
	# env looks like a temp solution https://github.com/ivan-hc/Steam-appimage/issues/5#issuecomment-2254209170

	domenu "${FILESDIR}/Steam-AppImage.desktop"
}
