# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg

DESCRIPTION="A GPU-accelerated cross-platform terminal emulator and multiplexer"
HOMEPAGE="https://wezterm.org/"

NIGHTLY_ARCHIVE="wezterm-nightly.Ubuntu24.04.tar.xz"

S="${WORKDIR}/wezterm"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
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
	local bin

	[[ -d "${S}/usr/bin" ]] || die "archive layout changed: missing usr/bin/"
	[[ -d "${S}/usr/share" ]] || die "archive layout changed: missing usr/share/"
	[[ -d "${S}/etc" ]] || die "archive layout changed: missing etc/"

	for bin in "${S}"/usr/bin/*; do
		[[ -f "${bin}" ]] || continue
		dobin "${bin}"
	done

	insinto /usr/share
	doins -r "${S}"/usr/share/*

	insinto /etc
	doins -r "${S}"/etc/*
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
