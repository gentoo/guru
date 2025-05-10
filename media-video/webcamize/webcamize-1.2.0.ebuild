# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="Use almost any camera as a webcam—DSLRs, mirrorless, camcorders, and even point-and-shoots"
HOMEPAGE="https://github.com/cowtoolz/webcamize"
SRC_URI="https://github.com/cowtoolz/webcamize/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"

src_install() {
	dobin webcamize
	if use systemd; then
		elog "Installing webcamize systemd service"
		systemd_dounit webcamize.service
	fi
}
