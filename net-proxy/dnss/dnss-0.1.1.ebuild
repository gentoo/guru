# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
ZIG_SLOT="0.16"

inherit zig systemd

DESCRIPTION="A small, speedy DNS proxy and bad-stuff-blocker"
HOMEPAGE="https://codeberg.org/zacoons/dnss"
LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64"

IUSE="openrc systemd"

RDEPEND="
	openrc? ( sys-apps/openrc )
	systemd? ( sys-apps/systemd )
"
DEPEND="${RDEPEND}"

SRC_URI="https://codeberg.org/zacoons/dnss/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/dnss"

src_compile() {
	ezig build --release=fast
}

src_install() {
	zig_src_install

	# Example config
	if [[ ! -f "${S}/example.dnss.conf" ]]; then
		die "example.dnss.conf not found"
	fi
	insinto /etc
	newins "${S}/example.dnss.conf" dnss.conf.example

	# systemd service
	if use systemd; then
		if [[ ! -f "${S}/pkg/aur/systemd/dnss.service" ]]; then
			die "systemd service file not found at pkg/aur/systemd/dnss.service"
		fi
		systemd_dounit "${S}/pkg/aur/systemd/dnss.service"
	fi

	# OpenRC init script
	if use openrc; then
		if [[ ! -f "${S}/pkg/aur/openrc/dnss.service" ]]; then
			die "OpenRC script not found at pkg/aur/openrc/dnss"
		fi
		newinitd "${S}/pkg/aur/openrc/dnss" dnss
	fi
}