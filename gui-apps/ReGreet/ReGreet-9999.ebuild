# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3

EGIT_REPO_URI="https://github.com/rharish101/ReGreet.git"

DESCRIPTION="A clean and customizable GTK-based greetd greeter written in Rust"
HOMEPAGE="https://github.com/rharish101/ReGreet"

LICENSE="GPL-3"
SLOT="0"
DEPEND="x11-libs/gtk+:3
	gtk4? ( gui-libs/gtk )
"

RDEPEND="
	${DEPEND}
	gui-libs/greetd
"
BDEPEND="
	virtual/rust
"
IUSE="gtk4 logs"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_configure() {
	if use gtk4; then
		local myfeatures=(
			gtk4_8
		)
	fi
	cargo_src_configure
}

src_compile() {
	cargo_src_compile
}

src_install() {
	newbin "${WORKDIR}/${P}/target/release/regreet" regreet
}

src_post_install () {
	if use logs; then
		insinto /etc/tmpfiles.d/ && newins "${WORKDIR}/${P}/systemd-tmpfiles.conf" regreet.conf
		systemd-tmpfiles --create "$PWD/systemd-tmpfiles.conf"
	fi
}
