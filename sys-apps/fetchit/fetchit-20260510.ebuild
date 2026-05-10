EAPI=8

LUA_COMPAT=( lua5-4 )

inherit lua-single toolchain-funcs

DESCRIPTION="Minimal system info fetcher written in C with Lua configuration"
HOMEPAGE="https://codeberg.org/nzuum/fetchit"

COMMIT="b0ed7c1fe08d32fc26e458cd971930d550720462"
SRC_URI="https://codeberg.org/nzuum/fetchit/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="${LUA_DEPS}"
DEPEND="${RDEPEND}"

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="$(pkg-config --cflags lua) -I src" \
		LIBS="$(pkg-config --libs lua)"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install

	dodoc README.md

	insinto /usr/share/fetchit
	doins -r config/*
}