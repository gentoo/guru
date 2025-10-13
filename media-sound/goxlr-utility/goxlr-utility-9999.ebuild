# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A utility for monitoring and controlling a TC-Helicon GoXLR or GoXLR Mini"
HOMEPAGE="https://github.com/GoXLR-on-Linux/goxlr-utility"

inherit cargo udev shell-completion desktop xdg

if [[ ${PV} == *9999* ]]; then
		EGIT_REPO_URI="https://github.com/GoXLR-on-Linux/${PN}.git"
		inherit git-r3
else
	SRC_URI="
		https://github.com/GoXLR-on-Linux/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		${CARGO_CRATE_URIS}
	"
	KEYWORDS="~amd64"
fi

LICENSE="MIT Music-Tribe"
LICENSE+="
        0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD CC0-1.0
        CDLA-Permissive-2.0 ISC MIT MPL-2.0 UoI-NCSA Unicode-3.0 Unlicense
        ZLIB
"
SLOT="0"
IUSE="tts"

RDEPEND="
	media-libs/libpulse
	dev-util/pkgconf
	sys-apps/dbus
	tts? (
		app-accessibility/speech-dispatcher
		llvm-core/clang
	)
"

src_unpack() {
	if [[ "${PV}" == *9999* ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_configure() {
	local myfeatures=(
		$(usev tts)
	)
	cargo_src_configure --no-default-features
}

src_install() {
		dobin "${WORKDIR}"/${P}/target/release/goxlr-daemon
		dobin "${WORKDIR}"/${P}/target/release/goxlr-client
		dobin "${WORKDIR}"/${P}/target/release/goxlr-defaults
		dobin "${WORKDIR}"/${P}/target/release/goxlr-launcher

		udev_dorules 50-goxlr.rules

		doicon -s 48 "${WORKDIR}"/${P}/daemon/resources/goxlr-utility.png
		doicon -s scalable "${WORKDIR}"/${P}/daemon/resources/goxlr-utility.svg
		newicon "${WORKDIR}"/${P}/daemon/resources/goxlr-utility-large.png goxlr-utility.png
		domenu "${WORKDIR}"/${P}/daemon/resources/goxlr-utility.desktop

		# Grab the Path where the AutoComplete scripts are..
		AUTOCOMPLETE=$("${WORKDIR}"/${P}/ci/cargo-out-dir target/release/ client-stamp)
		dobashcomp $AUTOCOMPLETE/goxlr-client.bash
		dofishcomp $AUTOCOMPLETE/goxlr-client.fish
		dozshcomp $AUTOCOMPLETE/_goxlr-client

		dodoc README.md
}

pkg_postinst() {
	udev_reload
	xdg_icon_cache_update
	elog ""
	elog "If you use systemd, make sure Pulseaudio is running for the GoXLR utility to work."
	elog ""
	elog "It's recommended to start pulseaudio via its systemd user units:"
	elog ""
	elog "  systemctl --user enable pulseaudio.service pulseaudio.socket"
	elog ""
	elog "Root user can change system default configuration for all users:"
	elog ""
	elog "  systemctl --global enable pulseaudio.service pulseaudio.socket"
	elog ""
}

pkg_postrm() {
	udev_reload
	xdg_icon_cache_update
}
