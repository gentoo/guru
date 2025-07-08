# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.85.0"
LLVM_OPTIONAL=1
LLVM_COMPAT=( {18..20} )

inherit cargo llvm-r2 optfeature

DESCRIPTION="A feature-rich and resource-friendly replacement for i3status, written in Rust."
HOMEPAGE="https://github.com/greshake/i3status-rust/"
SRC_URI="${CARGO_CRATE_URIS}
	https://github.com/greshake/i3status-rust/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://home.cit.tum.de/~salu/distfiles/${P}-crates.tar.xz
	https://home.cit.tum.de/~salu/distfiles/${P}-man.1
"

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+="
	0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD CC0-1.0
	GPL-3+ ISC MIT MPL-2.0 MirOS Unicode-3.0 Unicode-DFS-2016
"
# ring crate
LICENSE+=" openssl"
SLOT="0"
KEYWORDS="~amd64"
IUSE="notmuch pipewire pulseaudio"
REQUIRED_USE="pipewire? ( ${LLVM_REQUIRED_USE} )"

DEPEND="dev-libs/openssl:=
	sys-apps/lm-sensors:=
	notmuch? ( net-mail/notmuch:= )
	pulseaudio? ( media-libs/libpulse )
	pipewire? ( >=media-video/pipewire-0.3:= )
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
	pipewire? ( $(llvm_gen_dep 'llvm-core/clang:${LLVM_SLOT}') )
"

PATCHES="${FILESDIR}"/gitless-hash-and-date.patch

QA_FLAGS_IGNORED="usr/bin/i3status-rs"

pkg_setup() {
	if use pipewire; then
		llvm-r2_pkg_setup
	fi
	rust_pkg_setup
}

src_prepare() {
	default
	local COMMIT="db4db28eda9bbf8b7fc61ddad65a00207be9368b"
	local DATE="2025-07-05"
	sed -e "s/%COMMIT%/${COMMIT:0:9}/" -e "s/%DATE%/${DATE}/" \
		-i build.rs || die
}

src_configure() {
	local myfeatures=(
		$(usev debug debug_borders)
		$(usev notmuch)
		$(usev pipewire)
		icu_calendar
		maildir
	)
	cargo_src_configure $(usex pulseaudio '' --no-default-features)
}

src_install() {
	cargo_src_install
	newman "${DISTDIR}"/${P}-man.1 i3status-rs.1
	insinto /usr/share/i3status-rust
	doins -r files/icons files/themes
	dodoc NEWS.md CONTRIBUTING.md
	docinto examples
	dodoc examples/*.toml
}

pkg_postinst() {
	optfeature_header "Configurable fonts for themes and icons:"
	optfeature "themes using the Powerline arrow char" media-fonts/powerline-symbols
	optfeature "the awesome{5,6} icon set" media-fonts/fontawesome
	optfeature_header "Status bar blocks with additional requirements:"
	optfeature "ALSA volume support" media-sound/alsa-utils
	optfeature "advanced/non-standard battery support" sys-power/apcupsd sys-power/upower
	optfeature "bluetooth support" net-wireless/bluez
	optfeature "KDE Connect support" kde-misc/kdeconnect
	optfeature "speedtest support" net-analyzer/speedtest-cli
	# optfeature "VPN support" net-vpn/nordvpn # nordvpn overlay
	elog "The music block supports all music players that implement the MPRIS"
	elog "interface. These include media-sound/rhythmbox, media-sound/mpv and"
	elog "www-client/firefox among others. MPRIS support may be built-in or"
	elog "require additional plugins."
}
