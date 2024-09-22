# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
"

inherit cargo

DESCRIPTION="Bespoke dotfile management for sharkgirls."
HOMEPAGE="https://codeberg.org/vimproved/blahajdots"

if [[ "${PV}" = "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/vimproved/blahajdots.git"
else
	SRC_URI="https://codeberg.org/vimproved/blahajdots/archive/v${PV}.tar.gz -> ${P}.tar.gz
		${CARGO_CRATE_URIS}"
	S="${WORKDIR}/${PN}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3+"
# Dependent crate licenses
LICENSE+="
	MIT Unicode-DFS-2016
	|| ( Apache-2.0 Boost-1.0 )
"
SLOT="0"
IUSE="+gsettings"

DEPEND="gsettings? ( dev-libs/glib:2= )"
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
		$(usev gsettings)
	)

	cargo_src_configure --no-default-features
}
