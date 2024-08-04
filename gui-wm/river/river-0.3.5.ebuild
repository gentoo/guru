# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo

DESCRIPTION="A dynamic tiling Wayland compositor"
HOMEPAGE="https://isaacfreund.com/software/river/"

SRC_URI="
	https://codeberg.org/river/river/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://codeberg.org/ifreund/zig-pixman/archive/v0.2.0.tar.gz -> zig-pixman-0.2.0.tar.gz
	https://codeberg.org/ifreund/zig-wayland/archive/v0.2.0.tar.gz -> zig-wayland-0.2.0.tar.gz
	https://codeberg.org/ifreund/zig-wlroots/archive/v0.18.0.tar.gz -> zig-wlroots-0.18.0.tar.gz
	https://codeberg.org/ifreund/zig-xkbcommon/archive/v0.2.0.tar.gz -> zig-xkbcommon-0.2.0.tar.gz
"
S="${WORKDIR}/${PN}"

PATCHES=(
	"${FILESDIR}/${P}-build-zig-zon.patch"
	"${FILESDIR}/${P}-zig-0.12.0.patch"
)

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+llvm +man pie xwayland bash-completion zsh-completion fish-completion"

EZIG_MIN="0.12"

DEPEND="
	|| ( dev-lang/zig-bin:${EZIG_MIN} dev-lang/zig:${EZIG_MIN} )
	dev-libs/wayland
	gui-libs/wlroots:0.18
	x11-libs/libxkbcommon
	x11-libs/pixman
"
RDEPEND="${DEPEND}"

# https://github.com/ziglang/zig/issues/3382
QA_FLAGS_IGNORED="usr/bin/*"

ezig_build() {
	EZIG=zig
	edo "${EZIG}" build "${ZIG_BUILD_ARGS[@]}" "${@}"
}

src_unpack() {
	default

	mkdir "${S}/deps" || die
	mv zig-pixman "${S}/deps" || die
	mv zig-wayland "${S}/deps" || die
	mv zig-wlroots "${S}/deps" || die
	mv zig-xkbcommon "${S}/deps" || die
}

src_configure() {
	export ZIG_BUILD_ARGS=(
		-Doptimize=ReleaseSafe

		-Dpie=$(usex pie true false)
		-Dno-llvm=$(usex llvm false true)
		-Dman-pages=$(usex man true false)
		-Dbash-completion=$(usex bash-completion true false)
		-Dzsh-completion=$(usex zsh-completion true false)
		-Dfish-completion=$(usex fish-completion true false)
		-Dxwayland=$(usex xwayland true false)
	)
}

src_compile() {
	ezig_build
}

src_test() {
	ezig_build test
}

src_install() {
	ezig_build install --prefix "${ED}/usr"

	dodoc README.md

	insinto /usr/share/wayland-sessions
	doins contrib/river.desktop

	insinto /usr/share/${PN}
	doins -r example
}
