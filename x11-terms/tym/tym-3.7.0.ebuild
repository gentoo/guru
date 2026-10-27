# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{3,4} luajit )
inherit autotools lua-single systemd xdg

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/endaaman/tym"
else
	SRC_URI="https://github.com/endaaman/tym/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Lua-configurable terminal emulator"
HOMEPAGE="https://github.com/endaaman/tym"

LICENSE="MIT"
SLOT="0"
IUSE="test"

REQUIRED_USE="${LUA_REQUIRED_USE}"
RESTRICT="!test? ( test )"

DEPEND="
	${LUA_DEPS}
	x11-libs/gtk+:3
	>=x11-libs/vte-0.78
"
RDEPEND="${DEPEND}
	dev-libs/glib
	dev-libs/libpcre2
	x11-libs/cairo
	x11-libs/pango
"

src_prepare() {
	default

	# the categories provided by eclass do a better job than upstream, and
	# having duplicate list of categories fails on QA
	sed -i '/^Categories=.*$/d' "${S}"/tym-daemon.desktop "${S}"/tym.desktop || die

	eautoreconf
}

src_configure() {
	econf \
		--enable-luajit=$(usex lua_single_target_luajit yes no)
}

src_install() {
	emake DESTDIR="${D}" systemunitdir="$(systemd_get_userunitdir)" install

	einstalldocs
}
