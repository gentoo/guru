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
LICENSE="MIT"
SLOT="0"

DEPEND="dev-libs/openssl:="

RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	# bug comment 937042#c3
	sed -e '/^DEFAULT_TARGETS += libfsverity.a/d' \
		-e '/install -m644 libfsverity.a/d' \
		-i Makefile || die
	default
}

src_compile() {
	export PKGCONF="$(tc-getPKG_CONFIG)" USE_SHARED_LIB=1 V=1
	tc-export AR CC
	default
}

src_install() {
	emake install DESTDIR="${D}" PREFIX="${EPREFIX}/usr" \
		LIBDIR="${EPREFIX}/usr/$(get_libdir)"
	dodoc {README,NEWS}.md
}
