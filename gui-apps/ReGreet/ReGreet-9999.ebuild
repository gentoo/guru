# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo readme.gentoo-r1 tmpfiles
DESCRIPTION="A clean and customizable GTK-based greetd greeter written in Rust"
HOMEPAGE="https://github.com/rharish101/ReGreet"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/rharish101/${PN}.git"
else
	SRC_URI="
		https://github.com/rharish101/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
		${CARGO_CRATE_URIS}
	"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	|| ( gui-wm/sway gui-wm/cage )
	systemd? ( sys-apps/systemd[sysv-utils] )
	openrc? ( sys-apps/openrc[sysv-utils] )
	gui-libs/gtk
	gui-libs/greetd
	dev-libs/glib
	media-libs/graphene
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/pango
"
IUSE="systemd openrc"

QA_FLAGS_IGNORED="/usr/bin/regreet"

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		unpack "${PN}.tar.gz"
		cargo_src_unpack
	fi
}

src_configure() {
	local myfeatures=(
		gtk4_8
	)

	cargo_src_configure
}

src_prepare() {
	default

	if use systemd; then
		sed -i 's/greeter/greetd/g' "${S}/systemd-tmpfiles.conf" || die
	fi
}

src_compile() {
	cargo_gen_config

	# Export default configuration
	export RUSTUP_TOOLCHAIN=stable
	export GREETD_CONFIG_DIR="/etc/greetd"
	export CACHE_DIR="/var/cache/regreet"
	export LOG_DIR="/var/log/regreet"
	export SESSION_DIRS="/usr/share/xsessions:/usr/share/wayland-sessions"
	# Require sysv-utils useflag enable on the init system
	export REBOOT_CMD="reboot"
	export POWEROFF_CMD="poweroff"

	cargo_src_compile
}

src_install() {
	cargo_src_install

	if use systemd; then
		newtmpfiles "${WORKDIR}/${P}/systemd-tmpfiles.conf" regreet.conf
	elif use openrc; then
		keepdir /var/log/regreet
		fowners greetd:greetd /var/log/regreet
		fperms 0755 /var/log/regreet

		keepdir /var/cache/regreet
		fowners greetd:greetd /var/cache/regreet
		fperms 0755 /var/cache/regreet
	fi
	# Install ReGreet template config file as a doc
	dodoc "${WORKDIR}/${P}/regreet.sample.toml"

	# Create README.gentoo doc file
	readme.gentoo_create_doc

	elog "ReGreet sample config file available on: /usr/share/doc/${P}/regreet.sample.toml.bz2"
	elog "To use decompress it to /etc/greetd/regreet.toml"

}

src_post_install () {
	if use systemd; then
		# Run systemd-tmpfiles to create the log and cache folder
		tmpfiles_process regreet.conf
	fi

	# Print README.gentoo file in the elog
	readme.gentoo_print_elog
}
