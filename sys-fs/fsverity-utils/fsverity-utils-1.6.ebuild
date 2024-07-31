# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info
inherit toolchain-funcs

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://git.kernel.org/pub/scm/fs/fsverity/fsverity-utils.git"
	inherit git-r3
else
	SRC_URI="https://git.kernel.org/pub/scm/fs/fsverity/${PN}.git/snapshot/${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~riscv ~x86"
fi

DESCRIPTION="Userspace utility for file-level integrity/authenticity verification"
HOMEPAGE="https://git.kernel.org/pub/scm/fs/fsverity/fsverity-utils.git"
LICENSE="GPL-2"
SLOT="0"

DEPEND="dev-libs/openssl:="

RDEPEND="${DEPEND}"

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake install CC="$(tc-getCC)" DESTDIR="${D}" PREFIX="${EPREFIX}/usr" LIBDIR="${EPREFIX}/usr/$(get_libdir)"
}
