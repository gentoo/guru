# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.95"

inherit cargo desktop

DESCRIPTION="A lightning-fast cross-platform image viewer and video player"
HOMEPAGE="https://lightningview.app"
SRC_URI="
	https://github.com/dividebysandwich/LightningView/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
	https://github.com/Darllowin/guru-distfiles/releases/download/LightningView-${PV}/${P}-vendored-dependencies.tar.xz
"

# GitHub tarball unpacks to LightningView-${PV}, not ${P}
S="${WORKDIR}/LightningView-${PV}"
ECARGO_VENDOR="${WORKDIR}/vendor"

LICENSE="GPL-2"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD Boost-1.0 CC0-1.0 ISC MIT MPL-2.0
	Unicode-3.0 Unlicense ZLIB
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="alsa pipewire pulseaudio wayland X"
REQUIRED_USE="|| ( X wayland )"

DEPEND="
	media-video/ffmpeg:=
	media-libs/fontconfig:=
	media-libs/libglvnd
	x11-libs/libdrm
	x11-libs/libxkbcommon:=
	X? (
		x11-libs/cairo
		x11-libs/libX11
		x11-libs/libXcursor
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXft
		x11-libs/libXi
		x11-libs/libXinerama
		x11-libs/libXrandr
		x11-libs/libXrender
		x11-libs/libXScrnSaver
		x11-libs/libXtst
		x11-libs/libXxf86vm
		x11-libs/pango
	)
	wayland? (
		dev-libs/libinput
		dev-libs/wayland
	)
	alsa? ( media-libs/alsa-lib )
	pipewire? ( media-video/pipewire:= )
	pulseaudio? ( media-libs/libpulse:= )
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-build/cmake
	virtual/pkgconfig
"

# SDL3-src builds native code; ignore pre-stripped Rust binary QA check
QA_FLAGS_IGNORED="usr/bin/lightningview"

src_prepare() {
	default

	# Append git-source mappings to the eclass-generated cargo config.
	cat >> "${ECARGO_HOME}/config.toml" <<-EOF || die
	[source."git+https://github.com/dividebysandwich/imagepipe?rev=cc9df677"]
	git = "https://github.com/dividebysandwich/imagepipe"
	rev = "cc9df677"
	replace-with = "gentoo"

	[source."git+https://patched@github.com/dividebysandwich/dnglab.git?rev=06dc3dab"]
	git = "https://patched@github.com/dividebysandwich/dnglab.git"
	rev = "06dc3dab"
	replace-with = "gentoo"
	EOF

	# cmake-rs crate (sdl3-src) finds cmake via $PATH. Inject a wrapper
	# that passes SDL backend-disable flags for the configure step only.
	if ! use X || ! use wayland; then
		mkdir -p "${T}/cmake-wrap" || die
		cat > "${T}/cmake-wrap/cmake" <<-EOS || die
		#!/bin/sh
		case "\$*" in
			*--build*|*--install*|*-E*)
				exec /usr/bin/cmake "\$@"
				;;
		esac
		flags=
		$(if ! use X;       then echo 'flags="$flags -DSDL_X11=OFF"'; fi)
		$(if ! use wayland; then echo 'flags="$flags -DSDL_WAYLAND=OFF"'; fi)
		exec /usr/bin/cmake \$flags "\$@"
		EOS
		chmod +x "${T}/cmake-wrap/cmake" || die
		export PATH="${T}/cmake-wrap:${PATH}"
	fi
}

src_install() {
	# --frozen: all deps are in the vendor tarball, Cargo.lock is complete
	set -- "${CARGO}" install --path ./ --root "${ED}/usr" --frozen \
		$(usex debug --debug "") \
		${ECARGO_ARGS[@]}
	einfo "${@}"
	cargo_env "${@}" || die "cargo install failed"
	rm -f "${ED}/usr/.crates.toml" || die
	rm -f "${ED}/usr/.crates2.json" || die

	domenu "${S}/lightningview.desktop"
	doicon "${S}/lightningview.png"
}

pkg_postinst() {
	einfo "To force a specific video backend at runtime:"
	einfo "  SDL_VIDEO_DRIVER=wayland lightningview <file>"
	einfo "  SDL_VIDEO_DRIVER=x11 lightningview <file>"
	einfo "Config file: ~/.config/lightningview/config.toml"
}
