# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo shell-completion

DESCRIPTION="Elkowars Wacky Widgets is a standalone widget system made in Rust"
HOMEPAGE="https://elkowar.github.io/eww/"
SRC_URI="https://git.sr.ht/~antecrescent/gentoo-files/blob/main/gui-apps/eww/${P}-shellcomp.tar.xz"

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/elkowar/eww.git"
else
	SRC_URI+="
		https://github.com/elkowar/eww/archive/v${PV}.tar.gz -> ${P}.tar.gz
		${CARGO_CRATE_URIS}
	"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD CC0-1.0 ISC LGPL-3
	Unicode-DFS-2016
"
SLOT="0"
IUSE="X wayland"
REQUIRED_USE="|| ( X wayland )"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libdbusmenu[gtk3]
	x11-libs/cairo[glib]
	x11-libs/gdk-pixbuf:2[jpeg]
	x11-libs/gtk+:3[X?,wayland?]
	x11-libs/pango
	wayland? ( gui-libs/gtk-layer-shell )
"
# transitively hard-depend on xorg-proto due to gdk-3.0.pc
DEPEND="${RDEPEND}
	x11-base/xorg-proto
"
BDEPEND="
	virtual/pkgconfig
	>=virtual/rust-1.74.0
"

QA_FLAGS_IGNORED="usr/bin/.*"

src_unpack() {
	if [[ "${PV}" == 9999 ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
		unpack ${P}-shellcomp.tar.xz
	else
		cargo_src_unpack
	fi
}

src_configure() {
	local myfeatures=(
		$(usev X x11)
		$(usev wayland wayland)
	)
	cargo_src_configure --no-default-features
}

src_install() {
	dobashcomp "${WORKDIR}"/eww
	dofishcomp "${WORKDIR}"/eww.fish
	dozshcomp "${WORKDIR}"/_eww

	dodoc README.md CHANGELOG.md
	cargo_src_install --path crates/eww
}

pkg_postinst() {
	elog "Eww wont run without a config file (usually in ~/.config/eww)."
	elog "For example configs visit https://github.com/elkowar/eww#examples"
}
