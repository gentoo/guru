# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature toolchain-funcs

DESCRIPTION="A powerful light-weight programming language designed for extending applications"
HOMEPAGE="https://www.lua.org/"
SRC_URI="https://www.lua.org/ftp/${P}.tar.gz"

LICENSE="MIT"
SLOT="5.5"
KEYWORDS="~amd64 ~x86"
IUSE="readline"

DEPEND="
	>=app-eselect/eselect-lua-3
	readline? ( sys-libs/readline:= )
	!dev-lang/lua:0"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		AR="$(tc-getAR) rcu" \
		RANLIB="$(tc-getRANLIB)" \
		MYCFLAGS="${CFLAGS}" \
		MYLDFLAGS="${LDFLAGS}" \
		linux
}

src_install() {
	emake \
		INSTALL_TOP="${ED}/usr" \
		INSTALL_MAN="${ED}/usr/share/man/man1" \
		install
	find "${ED}" -name '*.la' -delete || die
	dodoc README
}

pkg_postinst() {
	eselect lua set --if-unset "${PN}${SLOT}"
	optfeature "Lua support for Emacs" app-emacs/lua-mode
}
