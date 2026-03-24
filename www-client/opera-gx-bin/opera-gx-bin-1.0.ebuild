EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="Opera GX Browser (Binary Package)"
HOMEPAGE="https://www.opera.com/gx"
SRC_URI="https://download3.operacdn.com/ftp/pub/opera_gx/128.0.5807.97/linux/opera-gx-stable_128.0.5807.97_amd64.deb"

LICENSE="Opera-GX-EULA"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip test" 
#re-stripping an already stripped binary can lead to file corruption or 'QA Notice: Pre-stripped files found' warnings. 
#Using RESTRICT="strip" tells Portage to skip this step and leave the binary as-is.
#Same goes for the test in RESTRICT, since it's an ebuild for an already precompiled binary we don't compile anything - thus there is no need to run any tests which are for compiled software.
IUSE=""

RDEPEND="
    dev-libs/atk
    dev-libs/glib:2
    dev-libs/nspr
    dev-libs/nss
    media-libs/alsa-lib
    media-libs/fontconfig
    media-libs/freetype
    media-libs/mesa[gbm(+)]
    net-print/cups
    sys-apps/dbus
    virtual/libudev
    x11-libs/cairo
    x11-libs/libX11
    x11-libs/libXcomposite
    x11-libs/libXdamage
    x11-libs/libXext
    x11-libs/libXfixes
    x11-libs/libXrandr
    x11-libs/libxcb
    x11-libs/libxkbcommon
    x11-libs/pango
"

BDEPEND="sys-devel/binutils"

S="${WORKDIR}"

src_install() {
    if [[ -d usr ]]; then
        # Fix the .desktop file validation errors
        if [[ -f usr/share/applications/opera-gx.desktop ]]; then
            sed -i '/TargetEnvironment/d' usr/share/applications/opera-gx.desktop || die
        fi
        # Fix for the unexpected directory /usr/share/doc/opera-gx-stable
        if [[ -d usr/share/doc/opera-gx-stable ]]; then
            mkdir -p "${ED}/usr/share/doc/${PF}" || die
            # Unzip the changelog to fix the compression notice
            gunzip usr/share/doc/opera-gx-stable/changelog.gz || die
            cp -a usr/share/doc/opera-gx-stable/* "${ED}/usr/share/doc/${PF}/" || die
            rm -rf usr/share/doc/opera-gx-stable || die
        fi
        insinto /usr
        doins -r usr/*
    fi
    if [[ -d opt ]]; then
        insinto /opt
        doins -r opt/*
    fi
    fperms 0755 /usr/bin/opera-gx
}
