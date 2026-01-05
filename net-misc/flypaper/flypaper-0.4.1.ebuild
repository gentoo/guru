# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Externally bind or mark sockets on the fly"
HOMEPAGE="https://codeberg.org/iguanajuice/flypaper"
SRC_URI="https://codeberg.org/iguanajuice/flypaper/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/flypaper"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"

DEPEND="
	dev-libs/cJSON
	dev-libs/libbpf
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/bpftool
	llvm-core/clang
"

src_configure() {
	mkdir -p "${S}/build"
	ln -s "${WORKDIR}/${P}-build/vmlinux.h" "${S}/build/vmlinux.h"
	ln -s "${WORKDIR}/${P}-build/flypaper.skel.h" "${S}/build/flypaper.skel.h"

	local emesonargs=(
		$(usex systemd -Dsystemd=true -Dopenrc=true)
	)
	meson_src_configure
}
