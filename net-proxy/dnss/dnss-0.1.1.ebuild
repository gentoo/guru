# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
ZIG_SLOT="0.16"

inherit zig systemd

DESCRIPTION="A small, speedy DNS proxy and bad-stuff-blocker"
HOMEPAGE="https://codeberg.org/zacoons/dnss"
LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64"

IUSE="openrc systemd"

RDEPEND="
    openrc? ( sys-apps/openrc )
    systemd? ( sys-apps/systemd )
"

DEPEND="${RDEPEND}"

SRC_URI="https://codeberg.org/zacoons/dnss/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/dnss"

src_compile() {
    ezig build --release=fast
}

src_install() {
    zig_src_install

    # Install example config (dnss.conf is in the root of S)
    if [[ -f "${S}/dnss.conf" ]]; then
        insinto /etc
        newins "${S}/dnss.conf" dnss.conf.example
        elog "Installed example config as /etc/dnss.conf.example"
    else
        ewarn "dnss.conf not found in ${S}"
    fi

    if use systemd && [[ -f "${S}/dnss.service" ]]; then
        systemd_dounit "${S}/dnss.service"
        elog "Installed systemd service"
    elif use systemd; then
        ewarn "dnss.service not found"
    fi

    if use openrc && [[ -f "${S}/pkg/aur/openrc/dnss" ]]; then
        newinitd "${S}/pkg/aur/openrc/dnss" dnss
        elog "Installed OpenRC init script"
    elif use openrc; then
        ewarn "OpenRC script not found at pkg/aur/openrc/dnss"
    fi
}