# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.87.0"

inherit cargo optfeature

DESCRIPTION="Bespoke dotfile management for sharkgirls."
HOMEPAGE="https://codeberg.org/vimproved/blahajdots"

if [[ "${PV}" = "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/vimproved/blahajdots.git"
else
	SRC_URI="https://codeberg.org/vimproved/blahajdots/releases/download/v${PV}/${P}.tar.xz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3+"
# Dependent crate licenses
LICENSE+=" Apache-2.0 MIT MPL-2.0 Unicode-3.0 ZLIB"
SLOT="0"

QA_FLAGS_IGNORED="usr/bin/blahaj"

src_unpack() {
	if [[ "${PV}" = "9999" ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_install() {
	cargo_src_install

	insinto /usr/share/blahajdots
	doins -r builtins/*
}

pkg_postinst() {
	optfeature "gsettings backend support" gnome-base/gsettings-desktop-schemas
}
