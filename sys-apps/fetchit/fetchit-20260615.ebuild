EAPI=8

LUA_COMPAT=( lua5-4 )

inherit lua-single toolchain-funcs

DESCRIPTION="Minimal system info fetcher written in C with Lua configuration"
HOMEPAGE="https://codeberg.org/nzuum/fetchit"

COMMIT="a2bf22e58670ea0cf98c1f7ba488dc77ce38c102"
SRC_URI="https://codeberg.org/nzuum/fetchit/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/fetchit"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="${LUA_DEPS}"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="-I$(pkg-config --variable=includedir lua) -I src" \
		LIBS="$(pkg-config --libs lua)"
}

src_install() {
	dobin build/fetchit
	dodoc README.md
	insinto /usr/share/fetchit
	doins -r config/*
}

pkg_postinst() {
	elog "Fetchit requires a user configuration file."
	elog "To get started, copy the default configuration:"
	elog "  mkdir -p ~/.config/fetchit"
	elog "  cp /usr/share/fetchit/init.lua ~/.config/fetchit/"
	elog "You may also copy the logo directory:"
	elog "  cp -r /usr/share/fetchit/logos ~/.config/fetchit/"
	elog "Edit ~/.config/fetchit/init.lua to customize your output."
}