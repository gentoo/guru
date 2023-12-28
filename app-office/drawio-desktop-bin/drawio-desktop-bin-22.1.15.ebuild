# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

MY_PN="${PN/-bin/}"

DESCRIPTION="Diagram drawing application built on web technologies"
HOMEPAGE="https://github.com/jgraph/drawio-desktop"

SRC_URI="
	https://github.com/jgraph/${MY_PN}/releases/download/v${PV}/drawio-x86_64-${PV}.AppImage
	https://github.com/jgraph/drawio-desktop/archive/v${PV}.tar.gz -> ${P}.tar.gz
"
KEYWORDS="-* ~amd64"

LICENSE="Apache-2.0"
SLOT="0"
RESTRICT="strip"

RDEPEND="sys-fs/fuse:0"

S="${WORKDIR}"

QA_PREBUILT="*"

src_install() {
	newbin "${DISTDIR}/drawio-x86_64-${PV}.AppImage" drawio-appimage

	pushd "${MY_PN}-${PV}/build" || die
	for f in *x*.png; do
		case "${f}" in
			# not all icon sizes are supported
			720x720.png)
				continue
				;;
			*)
				newicon -s "${f%.png}" "${f}" "drawio.png"
				;;
		esac
	done
	popd || die

	make_desktop_entry \
		"/usr/bin/drawio-appimage" \
		"draw.io" \
		"drawio" \
		"Graphics;Office"
}
