# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit fcaps toolchain-funcs

DESCRIPTION="Zen monitor is monitoring software for AMD Zen-based CPUs"
HOMEPAGE="https://github.com/Ta180m/zenmonitor3"
KEYWORDS="~amd64"
SRC_URI="https://github.com/Ta180m/${PN}/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
IUSE="+caps cli policykit"

DEPEND="
	caps? ( sys-libs/libcap )
	cli? ( sys-libs/ncurses )
	x11-libs/gtk+:3
"
RDEPEND="
	${DEPEND}
	policykit? ( sys-auth/polkit )
	sys-kernel/zenpower3
"

PATCHES=( "${FILESDIR}/${PN}-makefile.patch" )

src_compile() {
	tc-export CC
	emake build
	use cli && emake build-cli
}

src_install() {
	dodoc README.md

	DESTDIR="${D}" emake install
	use cli && DESTDIR="${D}" emake install-cli
	if use policykit; then
		mkdir -p "${ED}/usr/share/polkit-1/actions" || die
		DESTDIR="${D}" emake install-polkit
	fi

	fcaps cap_sys_rawio,cap_dac_read_search+ep usr/bin/zenmonitor
	use cli && fcaps cap_sys_rawio,cap_dac_read_search+ep usr/bin/zenmonitor-cli
}
