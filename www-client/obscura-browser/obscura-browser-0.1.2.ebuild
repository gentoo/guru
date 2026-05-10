# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=""  # populate with: pycargoebuild .

inherit cargo

DESCRIPTION="Open-source headless browser for AI agents and web scraping"
HOMEPAGE="https://github.com/h4ckf0r0day/obscura"
SRC_URI="
	https://github.com/h4ckf0r0day/obscura/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="stealth"

BDEPEND="
	>=dev-lang/rust-1.75.0
	dev-util/ninja
	dev-build/gn
	dev-lang/python:3.11
	llvm-core/clang
"

RDEPEND=""

QA_FLAGS_IGNORED="usr/bin/obscura"

src_configure() {
	local myfeatures=(
		$(usev stealth)
	)
	cargo_src_configure
}

src_compile() {
	cargo_src_compile
}

src_install() {
	cargo_src_install
	dobin target/release/obscura
	dodoc README.md LICENSE
}

pkg_postinst() {
	elog "obscura is a single-binary headless browser."
	elog ""
	elog "Quick start:"
	elog "  obscura fetch https://example.com --eval \"document.title\""
	elog "  obscura serve --port 9222"
	if use stealth; then
		elog ""
		elog "Stealth mode compiled in. Use --stealth flag at runtime to activate."
	fi
}
