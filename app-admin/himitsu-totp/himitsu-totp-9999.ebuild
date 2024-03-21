# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "${PV}" = "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~sircmpwn/himitsu-totp"
else
	SRC_URI="https://git.sr.ht/~sircmpwn/himitsu-totp/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
fi

DESCRIPTION="TOTP support for Himitsu"
HOMEPAGE="https://git.sr.ht/~sircmpwn/himitsu-totp"
LICENSE="GPL-3"
SLOT="0"


RDEPEND="app-admin/himitsu:="
DEPEND="
	${RDEPEND}
	dev-lang/hare:=
"
BDEPEND="app-text/scdoc"

# hare binary
QA_FLAGS_IGNORED="usr/bin/hitotp"

src_prepare() {
	default

	sed -i 's|^use query;|use himitsu::query;|' cmd/hitotp/main.ha || die
}

src_configure() {
	sed -i 's;^PREFIX=.*;PREFIX=/usr;' Makefile || die
}

src_install() {
	einstalldocs
	dobin hitotp
}
