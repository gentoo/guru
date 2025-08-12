# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit unpacker desktop

DESCRIPTION="Google's 3D planet viewer"
HOMEPAGE="
	https://maps.google.com/intl/en/earth
	https://support.google.com/earth/answer/168344#zippy=%2Cdownload-a-google-earth-pro-direct-installer
"
SRC_URI="https://dl.google.com/dl/linux/direct/google-earth-pro-stable_7.3.6_amd64.deb"
S="${WORKDIR}"

# https://earth.google.com/intl/es-419/licensepro.html
LICENSE="Google-Enterprise-Geo-Master"
SLOT="0"
KEYWORDS="amd64"

src_install() {
    doins -r ${S}/usr/bin
    doins -r ${S}/opt

    fperms 0755 /opt/google/earth/pro/googleearth
    fperms 0755 /opt/google/earth/pro/googleearth-bin

    newicon -s 32 opt/google/earth/pro/product_logo_32.png Google_Earth.png
    make_desktop_entry google-earth-pro "Google Earth Pro" Google_Earth
}

