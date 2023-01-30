# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	anyhow-1.0.44
	cfg-if-1.0.0
	libc-0.2.105
	log-0.4.14
	memchr-2.4.1
	quick-xml-0.22.0
	xcb-0.10.1
"

inherit cargo

DESCRIPTION="Hide current window before launching external program, unhide after quitting"
HOMEPAGE="https://github.com/EmperorPenguin18/gobble"
SRC_URI="
	https://github.com/EmperorPenguin18/gobble/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

RDEPEND="
	x11-libs/libxcb
	doc? (
		app-text/pandoc
		app-arch/gzip
	)
"
DEPEND="${DEPEND}"

QA_FLAGS_IGNORED="usr/bin/.*"

src_compile() {
	cargo_src_compile --target-dir target
	if use doc; then
		pandoc gobble.1.md -s -t man -o gobble.1
		gzip -f gobble.1
	fi
}

src_install() {
	use doc && dodoc gobble.1.gz
	cd target/release || die
	dobin gobble
}
