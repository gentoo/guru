# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="BPQ32 Node Software for Linux"
HOMEPAGE="https://github.com/g8bpq/linbpq"

MY_PV="25.1"
SRC_URI="https://github.com/g8bpq/linbpq/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE="pulseaudio"

DEPEND="
    dev-qt/qtserialport:5
    dev-qt/qtmultimedia:5
    pulseaudio? ( media-libs/libpulse )
"
RDEPEND="${DEPEND}"

src_unpack() {
    default_src_unpack
    S="${WORKDIR}/linbpq-${PV}"
}

src_prepare() {
    default_src_prepare
	patch -p0 < "${FILESDIR}/remove-setcap.patch"
}

src_compile() {
    emake || die "emake failed"
}

src_install() {
    dobin "${S}/linbpq" 2>/dev/null || true

    if [[ -f "${S}/README.md" ]]; then
        dodoc "${S}/README.md"
    elif [[ -f "${S}/README" ]]; then
        dodoc "${S}/README"
    fi
	ewarn "Execute by hand:"
	ewarn "  sudo setcap 'CAP_NET_ADMIN=ep CAP_NET_RAW=ep CAP_NET_BIND_SERVICE=ep' /usr/bin/linbpq"
}
