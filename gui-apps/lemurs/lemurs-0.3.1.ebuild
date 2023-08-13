# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	autocfg@1.1.0
	bitflags@1.3.2
	cassowary@0.3.0
	cc@1.0.79
	cfg-if@1.0.0
	crossterm@0.20.0
	crossterm@0.22.1
	crossterm_winapi@0.8.0
	crossterm_winapi@0.9.0
	env_logger@0.9.3
	getrandom@0.2.8
	instant@0.1.12
	libc@0.1.12
	libc@0.2.139
	lock_api@0.4.9
	log@0.4.17
	memoffset@0.6.5
	mio@0.7.14
	miow@0.3.7
	nix@0.23.2
	ntapi@0.3.7
	numtoa@0.1.0
	pam@0.7.0
	pam-sys@0.5.6
	parking_lot@0.11.2
	parking_lot_core@0.8.6
	pgs-files@0.0.7
	ppv-lite86@0.2.17
	proc-macro2@1.0.51
	quote@1.0.23
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	redox_syscall@0.2.16
	redox_termios@0.1.2
	scopeguard@1.1.0
	serde@1.0.152
	serde_derive@1.0.152
	signal-hook@0.3.15
	signal-hook-mio@0.2.3
	signal-hook-registry@1.4.1
	smallvec@1.10.0
	syn@1.0.109
	termion@1.5.6
	toml@0.5.11
	tui@0.16.0
	unicode-ident@1.0.6
	unicode-segmentation@1.10.1
	unicode-width@0.1.10
	users@0.8.1
	users@0.11.0
	wasi@0.11.0+wasi-snapshot-preview1
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
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

DEPEND=""
RDEPEND="${DEPEND}
				sys-libs/pam
				systemd? ( sys-apps/systemd:= )"
BDEPEND=""

QA_FLAGS_IGNORED="usr/bin/lemurs"

src_prepare() {
	eapply_user
	# Run lemurs on tty7 so it doesn't conflict with agetty
	if ! use systemd ; then
		sed -i 's/tty = 2/tty = 7/' "${S}"/extra/config.toml || die "Sed on config.toml failed"
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

	if use debug ; then
		cd target/debug || die "Couldn't cd into target/debug"
	else
		cd target/release || die "Couldn't cd into target/release"
	fi

	dobin lemurs
}

pkg_postinst() {
	elog "Before starting lemurs you have to configure all your WMs/DEs manually,"
	elog "see: https://github.com/coastalwhite/lemurs#usage"
	elog "and disable your previous display manager."
	elog
	if use systemd ; then
		elog "To start lemurs:"
		elog "  systemctl start lemurs"
		elog "To boot it with the system:"
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
