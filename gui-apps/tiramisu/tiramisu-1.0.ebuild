# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="minimalistic desktop notifications provider"
HOMEPAGE="https://github.com/Sweets/tiramisu"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Sweets/tiramisu"
else
	SRC_URI="https://github.com/Sweets/tiramisu/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-libs/glib:2[dbus]"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	sed -i '/CFLAGS.*=/d' Makefile || die
}

src_configure() {
	tc-export CC
	default
}

src_install() {
	emake DESTDIR="${ED}" PREFIX=/usr install
}
