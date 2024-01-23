# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo
DESCRIPTION="A clean and customizable GTK-based greetd greeter written in Rust"
HOMEPAGE="https://github.com/rharish101/ReGreet"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/rharish101/ReGreet.git"
else
	SRC_URI="
		https://github.com/rharish101/${PN}/archive/refs/tags/${PV}.tar.gz -> >${PN}.tar.gz
		${CARGO_CRATE_URIS}
	"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
DEPEND="gui-libs/gtk
"

RDEPEND="
	${DEPEND}
	gui-libs/greetd
"
BDEPEND="
	virtual/rust
	media-libs/graphene
"
IUSE="logs"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_configure() {
	local myfeatures=(
		gtk4_8
	)
	cargo_src_configure
}

src_compile() {
	cargo_gen_config
	cargo_src_compile
}

src_install() {
	cargo_src_install
}

src_post_install () {
	if use logs; then
		insinto /etc/tmpfiles.d/ && newins "${WORKDIR}/${P}/systemd-tmpfiles.conf" regreet.conf
		systemd-tmpfiles --create "$PWD/systemd-tmpfiles.conf"
	fi
}
