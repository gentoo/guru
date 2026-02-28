# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Qt-based TCP Terminal for packet radio"
HOMEPAGE="https://github.com/g8bpq/QtTermTCP"
SRC_URI="https://github.com/g8bpq/QtTermTCP/archive/refs/tags/0.79.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE="pulseaudio"

BDEPEND="media-gfx/imagemagick"

DEPEND="
    dev-qt/qtserialport:5
    dev-qt/qtmultimedia:5
    pulseaudio? ( media-libs/libpulse )
"
RDEPEND="${DEPEND}"

src_unpack() {
    default_src_unpack
	S="${WORKDIR}/QtTermTCP-${PV}"
}

src_configure() {
    local myqmake
    myqmake=$(type -p qmake5 || type -p qmake)
    [[ -n $myqmake ]] || die "qmake5 or qmake nnot found."
    "$myqmake" || die "qmake failed"
}

src_prepare() {
    default_src_prepare

    cd "${WORKDIR}/QtTermTCP-${PV}" || die
	eapply -p0 "${FILESDIR}/qttermtcp.ini.patch"
}

src_compile() {
    emake || die "emake failed"
}

src_install() {
    dobin "${S}/QtTermTCP"

    if [[ -f "${S}/README.md" ]]; then
        dodoc "${S}/README.md"
    elif [[ -f "${S}/README" ]]; then
        dodoc "${S}/README"
    fi

    # Desktop Entry
    insinto /usr/share/applications
    doins "${FILESDIR}/qttermtcp.desktop"

    insinto /usr/share/pixmaps
	magick "${S}/icon1.ico[0]" "${D}/usr/share/pixmaps/QtTermTCP_icon.png" || die "Converting icon failed."

	ewarn "QtTermTCP.ini is saved in ~/.local/share/QtTermTCP/"
}
