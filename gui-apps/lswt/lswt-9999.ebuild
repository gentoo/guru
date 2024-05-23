# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="List Wayland toplevels"
HOMEPAGE="https://git.sr.ht/~leon_plickat/lswt/"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~leon_plickat/lswt"
else
	SRC_URI="https://git.sr.ht/~leon_plickat/lswt/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-v${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="dev-libs/wayland"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/wayland-scanner"

src_prepare() {
	default
	sed '/^CFLAGS/s/-Werror//' -i Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}
