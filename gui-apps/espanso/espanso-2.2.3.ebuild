# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=""

inherit cargo desktop fcaps linux-info systemd xdg-utils

DESCRIPTION="Cross-platform Text Expander written in Rust"
HOMEPAGE="https://espanso.org"
SRC_URI="https://github.com/espanso/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
DEPS_URI="https://github.com/freijon/${PN}/releases/download/v${PV}/${P}-crates.tar.xz"
SRC_URI+=" ${DEPS_URI}"

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD-2 BSD CC0-1.0 ISC MIT MPL-2.0 ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="wayland"

DEPEND="
	acct-group/input
	dev-libs/openssl
	sys-apps/dbus
	x11-libs/wxGTK
	wayland? (
		x11-libs/libxkbcommon[wayland]
	)
	!wayland? (
		x11-libs/libX11
		x11-libs/libxcb
		x11-libs/libXtst
		x11-libs/libxkbcommon[X]
	)
"
RDEPEND="${DEPEND}"

QA_FLAGS_IGNORED="usr/bin/${PN}"

pkg_setup() {
	CONFIG_CHECK="~INPUT_UINPUT"
	ERROR_INPUT_UINPUT="Espanso with Wayland needs the UINPUT"
	ERROR_INPUT_UINPUT+=" input device driver to detect user inputs. Without it,"
	ERROR_INPUT_UINPUT+=" Espanso will not work as intended"

	# Now do the actual checks setup above, but only when using wayland
	use wayland && linux-info_pkg_setup
	rust_pkg_setup
}

src_configure() {
	local myfeatures=(
		modulo
		native-tls
		$(usev wayland)
	)
	cargo_src_configure --verbose --no-default-features
}

src_compile() {
	cargo_src_compile -p "${PN}"
}

src_install() {
	cargo_src_install --path "${PN}"

	newicon -s 128 "espanso/src/res/linux/icon.png" "${PN}.png"
	domenu "espanso/src/res/linux/${PN}.desktop"

	# install the systemd-service (user level)
	sed -i "s|{{{espanso_path}}}|/usr/bin/espanso|g" "espanso/src/res/linux/systemd.service" || die
	systemd_newuserunit "espanso/src/res/linux/systemd.service" "${PN}.service"
}

pkg_postinst() {
	# See https://espanso.org/docs/install/linux/#adding-the-required-capabilities
	use wayland && fcaps cap_dac_override "usr/bin/${PN}"

	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
