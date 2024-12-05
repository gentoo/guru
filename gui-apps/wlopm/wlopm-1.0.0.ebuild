# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="wlr-output-power-management-v1 client"
HOMEPAGE="https://git.sr.ht/~leon_plickat/wlopm/"

inherit bash-completion-r1 toolchain-funcs

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~leon_plickat/wlopm"
else
	SRC_URI="https://git.sr.ht/~leon_plickat/wlopm/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-v${PV}"
	KEYWORDS="~amd64 ~arm64"
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
	# Makefile doesn't make sure this directory exists
	# which is a problem when using PREFIX
	install -d "${D}$(get_bashcompdir)"
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" BASHCOMPDIR="$(get_bashcompdir)" install
}
