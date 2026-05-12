# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
ZIG_SLOT="0.16"

inherit zig systemd git-r3

DESCRIPTION="A small, speedy DNS proxy and bad-stuff-blocker"
HOMEPAGE="https://codeberg.org/zacoons/dnss"
LICENSE="Unlicense"
SLOT="0"
KEYWORDS=""

IUSE="openrc systemd"

RDEPEND="
    openrc? ( sys-apps/openrc )
    systemd? ( sys-apps/systemd )
"

DEPEND="${RDEPEND}"

EGIT_REPO_URI="https://codeberg.org/zacoons/dnss.git"

src_compile() {
    ezig build --release=fast
}

src_install() {
    zig_src_install

    if [[ -f dnss.conf ]]; then
        insinto /etc
        newins dnss.conf dnss.conf.example
    fi

    if use systemd && [[ -f dnss.service ]]; then
        systemd_dounit dnss.service
    fi

    if use openrc && [[ -f pkg/aur/openrc/dnss ]]; then
        newinitd pkg/aur/openrc/dnss dnss
    fi
}