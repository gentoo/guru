# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo
DESCRIPTION="A clean and customizable GTK-based greetd greeter written in Rust"
HOMEPAGE="https://github.com/rharish101/ReGreet"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/rharish101/${PN}.git"
else
	SRC_URI="
		https://github.com/rharish101/${PN}/archive/refs/tags/${PV}.tar.gz -> >${PN}.tar.gz
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
	gtk4? ( gui-libs/gtk ) || ( x11-libs/gtk+ )
	gui-libs/greetd
"
BDEPEND="
	virtual/rust
	media-libs/graphene
"
IUSE="systemd openrc gtk4"

src_configure() {
	local myfeatures=(
		gtk4_8
	)

	cargo_src_configure
}

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
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
		insinto /etc/tmpfiles.d/ && newins "${WORKDIR}/${P}/systemd-tmpfiles.conf" regreet.conf
	elif use openrc; then
		dodir /var/log/regreet
		fowners greeter:greeter /var/log/regreet
		fperms 0755 /var/log/regreet

		dodir /var/cache/regreet
		fowners greeter:greeter /var/cache/regreet
		fperms 0755 /var/cache/regreet
	fi
	# Install ReGreet template config file as a doc
	docinto /usr/share/doc/regreet
	dodoc "${WORKDIR}/${P}/regreet.sample.toml"

	elog "ReGreet sample config file available on: /usr/share/regreet/regreet.sample.toml\n"
	elog "To use copy it to /etc/greetd/regreet.toml\n"
	elog "To configure greetd config.toml to use ReGreet use the ReGreet Readme\n"
	elog "Or the greetd gentoo wiki page\n"
	elog ""
	elog "/etc/greetd/config.toml - Exemple ReGreet config using cage\n"
	elog "-----------------------------------------------------------\n"
	elog "[terminal]\n"
	elog "vt = 7\n"
	elog ""
	elog "[default_session]\n"
	elog "command = "cage -s -- regreet"\n"
	elog "user = "greetd"\n"
	elog ""
	elog "Notes:"
	elog "1 - On single user system you can change user to your home user"
	elog "2 - For sway config refer to the Readme for more info"

}

src_post_install () {
	if use systemd; then
		# Run systemd-tmpfiles to create the log and cache folder
		systemd-tmpfiles --create "$PWD/systemd-tmpfiles.conf"
	fi
}
