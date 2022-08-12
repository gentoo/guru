# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/${PN}/${PN}"

SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
inherit go-module

DESCRIPTION="Automatically load and unload environment variables depending on the current dir"
HOMEPAGE="https://direnv.net"
LICENSE="MIT"
SLOT="0"

src_install() {
	dobin direnv
}
