# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick@1.0.2
	equivalent@1.0.1
	hashbrown@0.14.0
	indexmap@2.0.0
	lazy_static@1.4.0
	libc@0.2.147
	memchr@2.5.0
	proc-macro2@1.0.66
	quote@1.0.31
	regex@1.9.1
	regex-automata@0.3.3
	regex-syntax@0.7.4
	serde@1.0.174
	serde_derive@1.0.174
	serde_regex@1.1.0
	serde_spanned@0.6.3
	syn@2.0.27
	toml@0.7.6
	toml_datetime@0.6.3
	toml_edit@0.19.14
	unicode-ident@1.0.11
	winnow@0.5.0
"

inherit cargo

DESCRIPTION="Adblocker for Spotify"
HOMEPAGE="https://github.com/abba23/spotify-adblock/"
SRC_URI="
	https://github.com/abba23/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="GPL-3 MIT Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	media-sound/spotify
"

src_prepare(){
	default
	# assigned here to use get_libdir
	QA_FLAGS_IGNORED="usr/$(get_libdir)/${PN}.so"
}

src_install(){
	# executable
	SPOTIFY_HOME=/opt/spotify/spotify-client
	cat <<-EOF > "${T}/spotify-adblock" || die
		#! /bin/sh
		LD_LIBRARY_PATH="${SPOTIFY_HOME}" \\
		LD_PRELOAD=/usr/$(get_libdir)/spotify-adblock.so \\
		exec ${SPOTIFY_HOME}/spotify "\$@"
	EOF
	dobin "${T}/spotify-adblock"

	# library
	newlib.so target/$(usex debug debug release)/libspotifyadblock.so ${PN}.so

	# config
	insinto "/etc/${PN}"
	doins config.toml
}
