# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools edo toolchain-funcs

DESCRIPTION="Advanced system & process supervisor for Linux"
HOMEPAGE="
	https://troglobit.com/watchdogd.html
	https://github.com/troglobit/watchdogd
"
SRC_URI="https://github.com/troglobit/watchdogd/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="compat examples filenr generic loadavg meminfo systemd"

RDEPEND="
	dev-libs/confuse:=
	dev-libs/libite
	dev-libs/libuev
	systemd? ( sys-apps/systemd )
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	tc-export CC
	local myconf=(
		$(use_enable compat)
		$(use_enable examples)
		$(use_with filenr)
		$(use_with generic)
		$(use_with loadavg)
		$(use_with meminfo)
		$(use_with systemd)
	)
	econf "${myconf[@]}"
}

src_install() {
	default
	dodoc README.md ChangeLog.md doc/*
	if use examples; then
		dodir "/usr/libexec/${PN}"
		edo mv "${ED}"/usr/bin/ex* "${ED}/usr/libexec/${PN}/"
	fi
	edo find "${ED}" -name '*.la' -delete
}
