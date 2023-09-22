# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P="superfluous-returnz-d${PV}-data"

DESCRIPTION="Artisanal video-game about Superflu, the useless super-hero (data files)"
HOMEPAGE="https://studios.ptilouk.net/superflu-riteurnz/ https://ptilouk.itch.io/superfluous-returnz/"
SRC_URI="${MY_P}-only.zip"
S="${WORKDIR}/"
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="bindist fetch"

BDEPEND="app-arch/unzip"

pkg_nofetch() {
	einfo "Please buy and download ${SRC_URI} from:"
	einfo "  https://ptilouk.itch.io/superfluous-returnz/"
	einfo "and move it to your distfiles directory."
}

src_install() {
	mkdir -p "${ED}/usr/share/" || die
	cp -r "${WORKDIR}/${MY_P}/" "${ED}/usr/share/superflu-riteurnz-data" || die
}
