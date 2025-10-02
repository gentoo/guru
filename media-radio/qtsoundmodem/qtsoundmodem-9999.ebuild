# qtsoundmodem-9999.ebuild
EAPI=8

inherit git-r3

DESCRIPTION="Qt-based Sound Modem & Terminal for packet radio"
HOMEPAGE="https://www.cantab.net/users/john.wiseman/Documents/QtSoundModem.html"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="pulseaudio"

BDEPEND="media-gfx/imagemagick"

DEPEND="
    dev-qt/qtserialport:5
    dev-qt/qtmultimedia:5
    sci-libs/fftw
    pulseaudio? ( media-libs/libpulse )
"
RDEPEND="${DEPEND}"

EGIT_REPO_URI="https://git.hibbian.org/Hibbian/qtsoundmodem.git"

src_prepare() {
    default_src_prepare

    cd "${WORKDIR}/qtsoundmodem-${PV}" || die
	eapply -p0 "${FILESDIR}/qtsoundmodem.ini.patch"
}

src_configure() {
    local myqmake
    myqmake=$(type -p qmake5 || type -p qmake)
    [[ -n $myqmake ]] || die "qmake5 or qmake not found"
    "$myqmake" || die "qmake failed"
}

src_compile() {
    emake || die "emake failed"
}

src_install() {
    dobin "${S}/QtSoundModem"

    if [[ -f "${S}/README.md" ]]; then
        dodoc README.md
    elif [[ -f "${S}/README" ]]; then
        dodoc README
    fi

    # Desktop Entry
    insinto /usr/share/applications
    doins "${FILESDIR}/qtsoundmodem.desktop"

    insinto /usr/share/pixmaps
	magick "${S}/QtSoundModem.ico" "${D}/usr/share/pixmaps/QtSoundModem_icon.png" || die "Converting icon failed"

	ewarn "QtSoundModem.ini is saved in ~/.local/share/QtSoundModem/"
}
