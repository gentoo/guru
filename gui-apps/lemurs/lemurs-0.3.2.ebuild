# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	autocfg@1.1.0
	bitflags@1.3.2
	cassowary@0.3.0
	cc@1.0.83
	cfg-if@1.0.0
	crossterm@0.26.1
	crossterm_winapi@0.9.1
	env_logger@0.9.3
	getrandom@0.2.10
	humantime@2.1.0
	libc@0.2.148
	lock_api@0.4.10
	log@0.4.20
	memoffset@0.6.5
	mio@0.8.8
	nix@0.23.2
	once_cell@1.18.0
	pam@0.7.0
	pam-sys@0.5.6
	parking_lot@0.12.1
	parking_lot_core@0.9.8
	ppv-lite86@0.2.17
	proc-macro2@1.0.67
	quote@1.0.33
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	ratatui@0.21.0
	redox_syscall@0.3.5
	scopeguard@1.2.0
	serde@1.0.188
	serde_derive@1.0.188
	signal-hook@0.3.17
	signal-hook-mio@0.2.3
	signal-hook-registry@1.4.1
	smallvec@1.11.0
	syn@2.0.37
	toml@0.5.11
	unicode-ident@1.0.12
	unicode-segmentation@1.10.1
	unicode-width@0.1.11
	users@0.8.1
	uzers@0.11.3
	wasi@0.11.0+wasi-snapshot-preview1
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.48.0
	windows-targets@0.48.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.48.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_msvc@0.48.5
"
inherit cargo pam systemd

DESCRIPTION="A TUI Display/Login Manager"
HOMEPAGE="https://github.com/coastalwhite/lemurs"
SRC_URI="https://github.com/coastalwhite/lemurs/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz \
${CARGO_CRATE_URIS}"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD MIT Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"

RDEPEND="${DEPEND}
				sys-libs/pam
				systemd? ( sys-apps/systemd:= )
				!systemd? ( sys-apps/kbd )
"

QA_FLAGS_IGNORED="usr/bin/lemurs"

src_prepare() {
	eapply_user
	# Run lemurs on tty7 so it doesn't conflict with agetty
	# And replace systemd's reboot and shutdown commands
	if ! use systemd ; then
		sed -i 's/tty = 2/tty = 7/' "${S}"/extra/config.toml || die "Sed on config.toml failed"

		sed -i 's/shutdown_cmd = "systemctl poweroff -l"/shutdown_cmd = "poweroff"/' \
		"${S}"/extra/config.toml || die "Sed on config.toml failed"

		sed -i 's/reboot_cmd = "systemctl reboot -l"/reboot_cmd = "reboot"/' \
		"${S}"/extra/config.toml || die "Sed on config.toml failed"
	fi
}

src_install() {
	dodir /etc/lemurs
	keepdir /etc/lemurs/{wayland,wms}

	exeinto /etc/lemurs
	doexe "${S}"/extra/xsetup.sh

	insinto /etc/lemurs
	doins "${S}"/extra/config.toml

	dodoc "${S}"/README.md

	# Lemur's default PAM doesn't make elogind do its job
	# i.e. doesn't make /run/user/*
	newpamd "${FILESDIR}"/lemurs.pam lemurs

	newinitd "${FILESDIR}"/lemurs.initd lemurs
	systemd_dounit "${S}"/extra/lemurs.service

	dobin target/$(usex debug debug release)/lemurs
}

pkg_postinst() {
	elog "Before starting lemurs you have to configure all your WMs/DEs manually."
	elog "See: https://github.com/coastalwhite/lemurs#usage"
	elog
	if use systemd ; then
		elog "To start lemurs:"
		elog "  systemctl start lemurs"
		elog "To start it with the system:"
		elog "  systemctl enable lemurs"
		ewarn "This package has not yet been tested on a systemd system,"
		ewarn "so it may not function properly."
		ewarn "If possible, please email the package maintainer to confirm that it works (or not):"
		ewarn
		ewarn "Remigiusz Micielski <rmicielski@purelymail.com>"
		ewarn
	else
		elog "To start lemurs:"
		elog "  rc-service lemurs start"
		elog "To boot it with the system:"
		elog "  rc-update add lemurs"
	fi
}
