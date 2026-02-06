# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

DESCRIPTION="Fast system fetch written in D"
HOMEPAGE="https://github.com/wholos/logifetch"
EGIT_REPO_URI="https://github.com/wholos/logifetch.git"

inherit git-r3 

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
        sys-apps/pciutils
"
DEPEND="
        ${RDEPEND}
        dev-lang/dmd
        dev-build/just
"

src_compile() {
        just all
}

src_install() {
        dobin logifetch
}
