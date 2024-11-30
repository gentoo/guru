# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Filesystem to mount HTTP directory listings, with a permanent cache"
HOMEPAGE="https://github.com/fangfufu/httpdirfs"
SRC_URI="https://github.com/fangfufu/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/expat
	dev-libs/gumbo:=
	dev-libs/openssl:=
	net-misc/curl
	sys-apps/util-linux
	sys-fs/fuse:3
"
RDEPEND="${DEPEND}"
BDEPEND="sys-apps/help2man"
