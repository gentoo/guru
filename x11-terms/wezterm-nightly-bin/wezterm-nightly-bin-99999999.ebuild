# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg shell-completion

DESCRIPTION="A GPU-accelerated cross-platform terminal emulator and multiplexer"
HOMEPAGE="https://wezterm.org/"

NIGHTLY_ARCHIVE="wezterm-nightly.Ubuntu24.04.tar.xz"

S="${WORKDIR}/wezterm"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
PROPERTIES="live"
IUSE="wayland"

RESTRICT="mirror strip network-sandbox"

BDEPEND="
	net-misc/wget
"

RDEPEND="
	!x11-terms/wezterm
	dev-libs/openssl
	wayland? ( dev-libs/wayland )
	media-fonts/noto
	media-fonts/noto-emoji
	media-libs/fontconfig
	media-libs/mesa
	sys-apps/dbus
	x11-libs/cairo[X]
	x11-libs/libX11
	x11-libs/libxkbcommon[X,wayland?]
	x11-libs/xcb-util
	x11-libs/xcb-util-image
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-wm
	x11-themes/hicolor-icon-theme
"
# Trim dependencies from official x11-terms/wezterm
# dev-libs/openssl-compat
# media-fonts/jetbrains-mono
# media-fonts/roboto
# x11-themes/xcursor-themes

QA_PREBUILT="
	usr/bin/*
"

src_unpack() {
	local uri="https://github.com/wezterm/wezterm/releases/download/nightly/${NIGHTLY_ARCHIVE}"
	local tarball="${T}/${NIGHTLY_ARCHIVE}"

	wget \
		--max-redirect=20 \
		--tries=3 \
		--timeout=30 \
		-O "${tarball}" \
		"${uri}" \
		|| die "failed to download WezTerm nightly"

	tar -xJf "${tarball}" -C "${WORKDIR}" \
		|| die "failed to unpack WezTerm nightly"
}

src_install() {

	# gaurd against upstream archive changes
	[[ -d "${S}/usr/bin" ]] || die "archive layout changed: missing usr/bin/"
	[[ -d "${S}/usr/share" ]] || die "archive layout changed: missing usr/share/"
	[[ -d "${S}/etc" ]] || die "archive layout changed: missing etc/"

	# install binaries
	dobin "${S}"/usr/bin/open-wezterm-here
	dobin "${S}"/usr/bin/strip-ansi-escapes
	dobin "${S}"/usr/bin/wezterm
	dobin "${S}"/usr/bin/wezterm-gui
	dobin "${S}"/usr/bin/wezterm-mux-server

	# install desktop file
	domenu "${S}"/usr/share/applications/org.wezfurlong.wezterm.desktop

	# install icon
	doicon -s 128 "${S}"/usr/share/icons/hicolor/128x128/apps/org.wezfurlong.wezterm.png

	# install completion file
	dobashcomp "${S}"/usr/share/bash-completion/completions/wezterm
	dozshcomp "${S}"/usr/share/zsh/functions/Completion/Unix/_wezterm

	# install env/shell init script
	insinto /etc/profile.d
	doins "${S}"/etc/profile.d/wezterm.sh

	# install extra files
	insinto /usr/share/metainfo
	doins "${S}"/usr/share/metainfo/org.wezfurlong.wezterm.appdata.xml

	insinto /usr/share/nautilus-python/extensions
	doins "${S}"/usr/share/nautilus-python/extensions/wezterm-nautilus.py

}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
