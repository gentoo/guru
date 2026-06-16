# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
ZIG_SLOT="0.16"

inherit zig git-r3

DESCRIPTION="A small, speedy DNS proxy and bad-stuff-blocker"
HOMEPAGE="https://codeberg.org/zacoons/dnss"
EGIT_REPO_URI="https://codeberg.org/zacoons/dnss.git"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS=""

src_compile() {
	ezig build --release=fast
}

src_install() {
	zig_src_install

	# Example config
	if [[ -f "${S}/example.dnss.conf" ]]; then
		insinto /etc
		newins "${S}/example.dnss.conf" dnss.conf.example
	else
		ewarn "example.dnss.conf not found; skipping config example"
	fi
}