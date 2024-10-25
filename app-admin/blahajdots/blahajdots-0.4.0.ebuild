# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

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
LICENSE+="
	Apache-2.0-with-LLVM-exceptions MIT Unicode-DFS-2016
	|| ( Apache-2.0 Boost-1.0 )
"
SLOT="0"
IUSE="+gtk"

DEPEND="gtk? ( dev-libs/glib:2= )"
RDEPEND="${DEPEND}"

QA_FLAGS_IGNORED="usr/bin/blahaj"

src_unpack() {
	if [[ "${PV}" = "9999" ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_configure() {
	local myfeatures=(
		$(usev gtk gsettings)
	)

	cargo_src_configure --no-default-features
}
