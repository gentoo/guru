# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.0

EAPI=8

CRATES="
	aho-corasick-0.7.18
	lazy_static-1.4.0
	libc-0.2.119
	memchr-2.4.1
	proc-macro2-1.0.36
	quote-1.0.15
	regex-1.5.4
	regex-syntax-0.6.25
	serde-1.0.136
	serde_derive-1.0.136
	syn-1.0.86
	toml-0.5.8
	unicode-xid-0.2.2
"

inherit cargo

DESCRIPTION="Adblocker for Spotify"
HOMEPAGE="https://github.com/abba23/spotify-adblock/"
SRC_URI="
	https://github.com/abba23/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)
"
LICENSE="
	GPL-3
	|| ( Apache-2.0 MIT )
	|| ( MIT Unlicense )
"
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
